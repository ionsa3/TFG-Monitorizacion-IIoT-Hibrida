terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

# Se configura el proveedor para conectarse al socket local de Docker
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Descarga de la imagen oficial basada en Alpine Linux (minimiza superficie de ataque)
resource "docker_image" "mosquitto" {
  name         = "eclipse-mosquitto:2.0"
  keep_locally = true
}

# Creación de una red 'bridge' dedicada.
# Aislar el tráfico IoT del resto de la red del host 
# es un principio básico de segmentación de red en ciberseguridad industrial (ISA/IEC 62443).
resource "docker_network" "iot_network" {
  name = "iot_industrial_net"
}

# Despliegue del contenedor del Broker MQTT
resource "docker_container" "mqtt_broker" {
  name  = "mosquitto_broker"
  image = docker_image.mosquitto.image_id

  # Mapeo del puerto MQTT estándar
  ports {
    internal = 1883
    external = 1883
  }

  # Conexión a la red aislada
  networks_advanced {
    name = docker_network.iot_network.name
  }

  # Montaje de volúmenes para configuración y persistencia
  volumes {
    host_path      = "/home/ion/tfg-industrial-cloud/docker/mosquitto/config/mosquitto.conf"
    container_path = "/mosquitto/config/mosquitto.conf"
  }
  volumes {
    host_path      = "/home/ion/tfg-industrial-cloud/docker/mosquitto/data"
    container_path = "/mosquitto/data"
  }
}
