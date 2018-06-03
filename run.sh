#!/bin/bash

# substitute environment variables in the settings file
envsubh config/settings.json.handlebars config/settings.json

# run the service
node dist/api.js
