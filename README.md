# TFG: Arquitectura Híbrida IIO-T con mTLS y Edge Computing

## Descripción
Este proyecto implementa un nodo de borde (Edge) industrial utilizando **Terraform** para la orquestación de infraestructura y **Docker** para la contenedorización de servicios de mensajería MQTT (Mosquitto).

## Stack Tecnológico
* **IaC:** Terraform v1.15.2
* **Virtualización:** Docker Engine v24.x
* **Broker:** Eclipse Mosquitto 2.0
* **OS:** Ubuntu 22.04 LTS

## Despliegue Rapido
1. Acceder a `/terraform` y ejecutar `terraform init && terraform apply`.
2. Los servicios se levantarán automáticamente vinculados a la red `iot_industrial_net`.

## Licencia
Este proyecto está bajo la Licencia MIT.
