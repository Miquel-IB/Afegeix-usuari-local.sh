#!/bin/bash

# 1-Comprobar que se ejecuta como root

if [[ "${UID}" -ne 0 ]]
then
   echo 'Ingrese como root.' >&2
   exit 1
fi

# 2-Obtener el username (login)
read -p 'Indique su nombre de login: ' USUARIO

# 3-Obtener su nombre real
read -p 'Indique su nombre real: ' NOMBRE

# 4-Preguntar la contraseña
read -p 'Indique la contraseña: ' PASSWORD

# 5-Crear usuario
useradd -c "${NOMBRE}" -m ${USUARIO}

# 6-Comprobar que el usuario se ha añadido correctamente
if [[ "${?}" -ne 0 ]]
then
  echo 'No se ha creado correctamente el usuario'
  exit 1
fi
echo "Su nombre de usuario es ${USUARIO}"

# 7-Añadir la contraseña al usuario
echo ${PASSWORD} | passwd --stdin ${USUARIO}

# 8-Comprobar que la contraseña se ha añadido correctamente
if [[ "${?}" -ne 0 ]]
then
  echo 'Error con la contraseña'
  exit 1
fi
echo "Se ha añadido la contraseña al usuario ${USUARIO}"

# 9-Forzar al cambio de contraseña en el primer inicio de sesión
passwd -e ${USUARIO}

# 10-Mostrar el usuario, contraseña y el host donde se ha creado el usuario
host="echo `hostname`"
echo 'Su usuario es ${USUARIO}, su contraseña es ${PASSWORD} y el host es ${host}'
