# Betriebsdokumentation

## Einführung

Mithilfe der Scripte kann man sich das Laben mit Git erleichtern. Sie automatisieren manuelle Aufgaben automatisch und man spart sich so Zeit.

## Installationsanleitung für Administratoren

### Installation

Bevor die Scripte ausführbar sind muss folgender Befehl ausgeführt werden:

```
sudo apt install git
```

Er installiert Git und macht dabei die Scripte funktionstüchtig.

## Bediensanleitung Benutzer

### Script 1

Input file nach diesem Schema:
`<GIT-Url> <Verzeichnisname>`

Das Skript muss mit zwei Parametern ausgeführt werden.
`git_clone_update_repos.bash <input file> <target directory>`

### Script 2

Das Skript muss mit zwei Parametern ausgeführt werden.
Beide Parameter müssen pfade zu Directories sein.

`./git_extract_commits.bash <SourceDirectory> <TargetDirectory>`
