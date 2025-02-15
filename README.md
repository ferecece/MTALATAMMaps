# GTA Speedrun LATAM Racing Maps

Este repositorio contiene todos los mapas utilizados en el servidor de *MTA:SA* **[GTA Speedrun LATAM Racing](https://mta.gtaspeedrun.lat)**. Aquí encontrarás una colección de mapas organizados en diferentes categorías según su origen y tipo de juego.

## Estructura del Repositorio
El repositorio está dividido en dos carpetas principales:

### [**[Robot]**](https://gitlab.com/The123robot/robot-mta-server)
Esta carpeta contiene los mapas provenientes del servidor de **Robot**. Estos mapas no fueron creados originalmente para GTA Speedrun Latam Racing, pero están disponibles para su uso en el servidor.

### **[LATAM]**
Esta carpeta contiene **mapas originales creados exclusivamente para GTA Speedrun LATAM Racing**. Si deseas subir un nuevo mapa, **debes colocarlo en esta carpeta** siguiendo las reglas y requisitos establecidos.

---

## Requisitos básicos para subir un mapa
Para que el servidor acepte tu mapa, debes cumplir los siguientes requisitos mínimos:


1. **Etiqueta racetype en meta.xml:** Debes incluir la etiqueta correspondiente en el archivo `meta.xml`.
2. **Nombre adecuado de la carpeta:** El nombre de la carpeta del mapa debe seguir las convenciones establecidas.

Asegúrate de revisar manualmente que todo en el archivo `meta.xml` sea correcto antes de enviar el mapa. Ten en cuenta que el editor de mapas de *MTA:SA* tiende a borrar datos del `meta.xml` de forma aleatoria, así que mantente alerta ante posibles datos faltantes.

Si todo esto te parece complicado, puedes dejar una nota con tu envío y alguien del equipo se encargará de ajustarlo por ti.

## Subcarpeta
Coloca tu mapa en la carpeta **[LATAM]**, dentro de alguna de estas subcarpetas:
* **[R]** -> Race: Carreras de punto a punto.
* **[SR]** -> Speedrun: Carrera basada en una misión de un jugador o en una ruta de speedrun. Útil para practicar, descubrir nuevas rutas o disfrutar de la campaña de un jugador con amigos o desconocidos.
* **[DD]** -> Destruction Derby: ¡Elimina a otros jugadores e intenta ser el último en pie!
* **[TW]** -> Teamwork: Trabaja en equipo con un grupo seleccionado aleatoriamente para intentar ser el primer equipo en completar un circuito. Algunos miembros del equipo deberán ayudar a otros compañeros para que el equipo pueda completar el recorrido.
* **[MG]** -> Minigame: Compite contra otros jugadores en una tarea específica del mapa para ganar. Se te explicará la dinámica del minijuego cuando lo juegues.
* **[RANDOM]** -> Randomizer: Carreras con algún factor aleatorio, como vehículos aleatorios, handling aleatorio, etc.

## Etiqueta racetype
Los mapas requieren información dentro del meta.xml para que el servidor obtenga cierta información personalizada.

Anteriormente, las etiquetas de mapas (*R/DD/TW/MG/SR*) se incluían directamente en el nombre del mapa. Ahora, por favor, inclúyelas como un atributo separado, de esta manera:
```xml
<info gamemodes="race" type="map" name="Nombre" author="Tú" version="1.0" racetype="DD"></info>
```


Esto ayudará a mostrar correctamente el tipo de mapa en el servidor y en la página web para hacer una búsqueda de mapas por tipo.

## Nombre de la carpeta
Cada mapa tiene un nombre de carpeta que puede coincidir o no con el nombre del mapa definido en el meta.xml. Para evitar el caos en las carpetas, asegúrate de que sí coincidan. Observa los otros mapas y sigue el formato. Para más detalles, lee esto:
* La carpeta del mapa debe usar **PascalCase**.
* Solo utiliza letras A-Z, a-z y dígitos 0-9. Elimina signos de puntuación y marcas de acento. Usa la letra Q para representar signos de interrogación.
* Haz que coincida con el nombre real del mapa.
* Se pueden usar guiones para separar series (por ejemplo, Infernus Showdown/NC202154) o números de mapas (para mapas clásicos del archivo 2005-2008 cuyos nombres originales se han perdido) del título del mapa.

## Agradecimientos
Queremos agradecer a todos los creadores de mapas que han contribuido al crecimiento del servidor **GTA Speedrun LATAM Racing**.

- A la comunidad de **Robot** por permitirnos utilizar sus mapas y enriquecer la experiencia del servidor.
- A todos los creadores de mapas de **GTA Speedrun LATAM**, quienes han diseñado contenido original para este servidor, ayudando a expandir la variedad y la diversión dentro del juego.