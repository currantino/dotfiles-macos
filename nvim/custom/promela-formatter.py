#!/usr/bin/env python3

import sys
import re

INDENT_SIZE = 8  # Number of spaces per indentation level

def format_promela(code: str) -> str:
    """
    Formats Promela code by fixing indentation and spacing.
    """
    formatted_lines = []
    indent_level = 0
    inside_block = False

    for line in code.splitlines():
        stripped = line.strip()

        # Skip empty lines
        if not stripped:
            formatted_lines.append("")
            continue

        # Adjust indentation level for closing braces
        if stripped.startswith("}"):
            indent_level = max(0, indent_level - 1)

        # Apply indentation
        formatted_line = (" " * (indent_level * INDENT_SIZE)) + stripped
        formatted_lines.append(formatted_line)

        # Adjust indentation for opening braces
        if stripped.endswith("{"):
            indent_level += 1
            inside_block = True
        elif inside_block and stripped.endswith(";"):
            inside_block = False

    return "\n".join(formatted_lines) + "\n"


def main():
    """
    Reads Promela code from stdin, formats it, and prints it to stdout.
    """
    try:
        source_code = sys.stdin.read()
        formatted_code = format_promela(source_code)
        print(formatted_code, end="")  # Avoid extra newlines
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()

