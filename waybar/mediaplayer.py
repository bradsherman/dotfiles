#!/usr/bin/env python3
import subprocess
import json


def microseconds_to_mmss(microseconds):
    """Convert microseconds to MM:SS format"""
    try:
        seconds = int(microseconds) // 1000000
        minutes = seconds // 60
        seconds = seconds % 60
        return f"{minutes}:{seconds:02d}"
    except (ValueError, TypeError):
        return "0:00"


def get_active_player():
    """
    Select the best player based on:
    1. Actively playing players (prefer most recent, Spotify wins ties)
    2. Fallback to Spotify if available
    3. Fallback to any available player
    """
    try:
        players = (
            subprocess.check_output(["playerctl", "--list-all"])
            .decode("utf-8")
            .strip()
            .split("\n")
        )
        players = [p for p in players if p]  # filter empty
    except subprocess.CalledProcessError:
        return None

    if not players:
        return None

    # Get status for each player, track playing ones
    playing = []
    for p in players:
        try:
            status = (
                subprocess.check_output(["playerctl", "-p", p, "status"])
                .decode("utf-8")
                .strip()
            )
            if status == "Playing":
                playing.append(p)
        except subprocess.CalledProcessError:
            continue

    # If we have playing players, use most recent (last in list)
    # with Spotify winning ties
    if playing:
        spotify_playing = [p for p in playing if p.startswith("spotify")]
        if spotify_playing:
            return spotify_playing[-1]
        return playing[-1]

    # Nothing playing - fallback to spotify if available
    spotify_available = [p for p in players if p.startswith("spotify")]
    if spotify_available:
        return spotify_available[-1]

    # Final fallback - any available player
    return players[-1]


def get_player_status():
    try:
        # Get the best active player
        player = get_active_player()
        if not player:
            return {"text": "No music playing", "tooltip": "No active media player"}

        # Get track info
        artist = (
            subprocess.check_output(["playerctl", "-p", player, "metadata", "artist"])
            .decode("utf-8")
            .strip()
        )
        title = (
            subprocess.check_output(["playerctl", "-p", player, "metadata", "title"])
            .decode("utf-8")
            .strip()
        )
        status = (
            subprocess.check_output(["playerctl", "-p", player, "status"])
            .decode("utf-8")
            .strip()
        )

        # Get position and length
        try:
            position_us = (
                subprocess.check_output(["playerctl", "-p", player, "position"])
                .decode("utf-8")
                .strip()
            )
            position_seconds = int(float(position_us))
            position_formatted = f"{position_seconds // 60}:{position_seconds % 60:02d}"
        except:
            position_seconds = 0
            position_formatted = "0:00"

        try:
            length_us = (
                subprocess.check_output(
                    ["playerctl", "-p", player, "metadata", "mpris:length"]
                )
                .decode("utf-8")
                .strip()
            )
            length_seconds = int(length_us) // 1000000
            length_formatted = microseconds_to_mmss(length_us)
        except:
            length_seconds = 1
            length_formatted = "0:00"

        # Calculate progress percentage
        progress_percent = (
            min(100, max(0, (position_seconds / length_seconds) * 100))
            if length_seconds > 0
            else 0
        )

        # Format main text
        if status == "Playing":
            text = f"{artist} - {title}"
        else:
            text = f"! {artist} - {title}"

        # Create detailed tooltip
        tooltip = (
            f"{artist}\n{title}\n{status}\n{position_formatted} / {length_formatted}"
        )

        # Create class with progress info
        progress_class = (
            f"progress-{int(progress_percent // 10) * 10}"  # Round to nearest 10
        )
        class_name = f"{status.lower()}-{progress_class}"

        return {
            "text": text,
            "class": class_name,
            "tooltip": tooltip,
            "percentage": int(progress_percent),
        }
    except subprocess.CalledProcessError:
        return {"text": "No music playing", "tooltip": "No active media player"}
    except:
        return {"text": "No music playing"}


if __name__ == "__main__":
    print(json.dumps(get_player_status()))
