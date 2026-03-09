# 🔍 Sherlock - Observability Stack

Sistema centralizado de logs con Grafana + Loki para múltiples proyectos.

## 🚀 Quick Start

```bash
# Levantar servicios
docker-compose up -d

# Ver logs
docker-compose logs -f

# Detener
docker-compose down
```

## 🌐 Acceso

Grafana: http://localhost:3000
Usuario: `admin`
Password: `sherlock123`

Loki: http://localhost:3100

## 📱 Configurar Nueva App

1. Agregar app a `config/apps.json`

```json
{
  "name": "MiNuevaApp",
  "label": "mi-nueva-app",
  "lokiUrl": "http://localhost:3100",
  "labels": {
    "app": "mi-nueva-app",
    "platform": "mobile"
  }
}
```

> Esto es opcional y solo para tener la referencia del catalogo de apps que tenemos

2. Configurar la app para enviar logs

En tu aplicación, usa los labels configurados:

```json
{
  lokiUrl: "http://localhost:3100",
  labels: {
    app: "mi-nueva-app",
    platform: "mobile",
    env: process.env.NODE_ENV
  }
}
```

3. Ver logs en Grafana

- Ir a Explore
- Query: `{app="mi-nueva-app"}`
- Filtrar por nivel: `{app="mi-nueva-app"} | json | level="error"`

## 📊 Dashboards Disponibles

Sherlock - Overview: Vista general de todas las apps
Puedes importar más dashboards desde Grafana.com

## 🔧 Queries Útiles

```
# Todos los logs de una app
{app="cajaunica"}

# Errores de una app
{app="cajaunica"} | json | level="error"

# Logs de un módulo específico
{app="cajaunica"} | json | module="AuthStore"

# Buscar texto
{app="cajaunica"} |= "login"

# Múltiples apps
{app=~"cajaunica|otro-proyecto"}
```

## 📁 Retención

- Logs se mantienen por 30 días (configurable en `loki-config.yaml`)

## ✅ Verificar Instalación

Ejecuta el script de prueba incluido:

```ps1
.\scripts\test.bat

# Debería mostrar:
# 1. ready (Loki está corriendo)
# 2. Log enviado correctamente
# 3. Instrucciones para ver en Grafana
```
