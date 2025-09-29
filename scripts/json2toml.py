#!/usr/bin/env python3
import sys
import json
import toml


def main() -> int:
    data = json.loads(sys.stdin.read())
    print(toml.dumps(data))
    return 0


if __name__ == '__main__':
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print('Aborted!')
        sys.exit(1)
