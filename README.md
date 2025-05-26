# testyfy

Cómo compilar y ejecutar este proyecto:
- Usar flutter >= 3.7.0
 
En la carpeta base del proyecto ejecutar los siguientes comandos:
- "flutter pub get"
- "flutter packages run build_runner build --delete-conflicting-outputs"

Desde la configuración de "Run/Debug configurations" de Android Studio adjunto a flutter run O desde consola seguido de "flutter run":
- "--dart-define=CLIENT_ID=<CLIENT_ID> --dart-define=REDIRECT_URI=<REDIRECT_URL> --dart-define=CLIENT_SECRET=<CLIENT_SECRET>"
Estas credenciales deben ser obtenidas directamente de la pagina "developer.spotify.com"

NOTA:
Si bien este proyecto y todas sus librerías son compatibles con Android y IOS,
IOS requiere configuración adicional que no puedo realizar para garantizar la ejecución inmediata del proyecto, esta debe ser completada en Xcode en Mac.
Flutter no soporta aún compilación cruzada entre Windows (Mi dispositivo) y IOS.

Para completar la configuración en IOS se necesita:
- Asegurar que el proyecto nativo no tiene errores de configuración y dependencias al día
- Configurar aceptar el Deep Link "testyfy://auth/result"

La configuración en Android ya está completa.
