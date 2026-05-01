# bis-client-previews

Client-shareable design prototypes by Mikaela Yeo.

Each preview lives in `previews/<slug>-<hash>/` with a 6-char random hash so URLs aren't guessable. The root index does not list previews — they're discoverable only via direct link.

## Adding a new preview

```powershell
.\new-preview.ps1 likert-redesign
```

Creates `previews/likert-redesign-<hash>/index.html` and prints the share URL.

## URL pattern

```
https://mikaelayeo.github.io/bis-client-previews/previews/<slug>-<hash>/
```
