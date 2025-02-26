# Hotel Admin Flutter

Este es un proyecto personal en el que practiqué el uso de Firestore y Firebase Authentication para crear un sistema de administración de hoteles. El sistema permite gestionar la información de edificios, pisos y habitaciones, facilitando el control y mantenimiento de las instalaciones de un hotel.

## Funcionalidades

- Autenticación de usuarios: Los administradores pueden iniciar sesión usando Firebase Authentication. El sistema maneja la creación de cuentas, inicio de sesión y recuperación de contraseñas.
- Alta de edificios: Los administradores pueden añadir nuevos edificios al sistema, proporcionando detalles como el nombre, ubicación y características del edificio.
- Gestión de pisos: Los administradores pueden agregar y gestionar pisos dentro de cada edificio, asignar un número de piso y especificar la capacidad.
- Alta de habitaciones: Los administradores pueden crear habitaciones dentro de los pisos, definir características como el tipo de habitación, capacidad y estado.
- Mantenimiento de instalaciones: Permite registrar tareas de mantenimiento y verificar el estado actual de cada habitación y piso.

## Tecnologías utilizadas

- Flutter: Para la interfaz móvil (iOS y Android).
- Firebase Authentication: Para gestionar el registro e inicio de sesión de los administradores.
- Cloud Firestore: Para almacenar la información de edificios, pisos, habitaciones y tareas de mantenimiento en tiempo real.
- Firebase Firestore Security Rules: Para asegurar que solo los administradores puedan acceder y modificar los datos.

## Requisitos

- Flutter: Asegúrate de tener Flutter instalado en tu máquina. Si no lo tienes, sigue las instrucciones de instalación en Flutter's official website.
- Firebase Project: Debes tener un proyecto de Firebase configurado para poder usar Firestore y Firebase Authentication. Si aún no tienes uno, puedes crearlo desde la consola de Firebase: https://console.firebase.google.com/.

## Enviroment variables

To change the enviroment variables modify `lib\main.dart` and `lib\api\firestore_api.dart`

Run `firebase emulators:start` on the proyect to run emulatos of firestore and FireAuth

## Contribución

Si deseas contribuir al proyecto, por favor sigue los siguientes pasos:

1. Haz un fork del repositorio.
2. Crea una nueva rama para tus cambios.
3. Realiza los cambios y haz un commit con un mensaje claro.
4. Envía un pull request describiendo los cambios que has realizado.

## Licencia

Este proyecto está bajo la Licencia MIT. Para más detalles, revisa el archivo LICENSE.