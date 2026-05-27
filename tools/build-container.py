#!/usr/bin/env python3
"""
Inline template.tpl into the sample container's customTemplate[0].templateData field.

Single source of truth for the .tpl content stays in template.tpl. This script
runs on every release to produce the importable containers/retaint-ecommerce.json.

Usage:  python3 tools/build-container.py
"""

import json
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
TEMPLATE_PATH = REPO_ROOT / "template.tpl"
SOURCE_PATH = REPO_ROOT / "containers" / "retaint-ecommerce.source.json"
OUTPUT_PATH = REPO_ROOT / "containers" / "retaint-ecommerce.json"
PLACEHOLDER = "__TEMPLATE_DATA_PLACEHOLDER__"


def main() -> int:
    template_data = TEMPLATE_PATH.read_text(encoding="utf-8")
    source = json.loads(SOURCE_PATH.read_text(encoding="utf-8"))

    custom_templates = source["containerVersion"].get("customTemplate", [])
    if not custom_templates:
        print("error: source JSON has no customTemplate entry", file=sys.stderr)
        return 1

    if custom_templates[0].get("templateData") != PLACEHOLDER:
        print(
            f"error: customTemplate[0].templateData != {PLACEHOLDER!r} — "
            "did you edit the source by hand?",
            file=sys.stderr,
        )
        return 1

    custom_templates[0]["templateData"] = template_data

    OUTPUT_PATH.write_text(
        json.dumps(source, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    print(f"wrote {OUTPUT_PATH.relative_to(REPO_ROOT)} "
          f"({len(template_data)} bytes of template inlined)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
