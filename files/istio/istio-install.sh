#!/bin/bash
istioctl install --set values.kiali.enabled=true --set values.tracing.enabled=true