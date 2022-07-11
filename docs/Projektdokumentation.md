# Projekt Dokumentation

[[_TOC_]]

## Lösungsdesign

Anhand der Analyse wurde folgendes Lösungsdesign entworfen.

### Aufruf der Skripte

TODO: schreiben sie wie die Skripte aufgerufen werden sollen (d.h. welche Parameter werden übergeben, gibt es Interaktionen mit dem Skript, läuft es automatisch täglich ab?)

### Ablauf der Automation

# Skript 1: [git_clone_update_repos.bash](../bin/Script_1/git_clone_update_repos.bash)

![Script 1](../images/script1_solution_design.drawio.png)

## Vorbereitungen

## Parameter

## Ablauf

# Skript 2: [git_extract_commits.bash](../bin/Script_2/git_extract_commits.bash)

![Script 2](../images/script2_solution_design.drawio.png)

## Vorbereitungen
Damit das Programm funktionieren kann muss folgender Befehl ausgeführt werden:
```
sodo apt install git
```
Dabei wird git heruntergeladen. Es wird benötigt um die Commit Messages auszulesen.

## Parameter

### Parameter 1 (Path):
Es muss angegeben welches Directory nach repos durchsucht werden soll. Dabei kann einfach der Pfad zu dem Directroy angegeben werden.

### Parameter 2 (Path):
Es muss angegeben werden in welches Directory die Output CSV Dateien gespeichert werden sollen.

### Fehlerhafte Parameter
Bei falschen oder fehlenden Parametern wird eine spezifische Fehlermeldung angezeigt. So kann man den fehler schnell erkennen und beheben. Das Script führt keine befehle aus, bevor nicht alle Parameter korrekt sind.

## Ablauf
Das angegebene Directory wird auf Git Repositories durchsucht. Diese werden im Terminal angzeigt.

Ebenfalls werden die "Nicht-Repo" Directories angezeigt.

Von den Repositories werden dan jeweils die Logs ausgelesen und formatiert in einem CSV File gespeichert. 

## Terminal Output
Im Terminal werden sämtliche Fehlermeldungen angezeigt. Anhand der Fehlermeldungen kann erkennt werden was falsch gelaufen ist.

Ebenfalls werden die Repositories und die nicht-Repositories angezeigt. Jeweils in einer anderen Farbe.

## File Output (CSV)
Die Logs der Repositories werden im angegebenen Directory in einer CSV Datei gespeichert. Der Separator ist ein ','. 
Zu dem Namen des Files wird jeweils eine unique ID hinzugefügt, um doppelte Files zu vermeiden.


