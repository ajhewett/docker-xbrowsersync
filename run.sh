#!/bin/bash

# substitute environment variables in the settings template to create a settings file
envsub --syntax handlebars config/settings-template.json config/settings.json

# run the service
node dist/api.js
