# Hermes agent image for Podpiwas coders: kagent's Hermes sandbox plus our persona.
# The base is pinned by digest: Substrate admission accepts digest-pinned images only,
# and this is the image kagent 0.10.5 uses by default.
FROM ghcr.io/kagent-dev/kagent/acp-sandbox-hermes@sha256:6c224c7f07d576055db38e85847a9e9dbc9ca4818ce6f55442393b79ba1441fb

# Hermes reads its persona from $HERMES_HOME/SOUL.md; HOME is /home/agent.
COPY --chown=agent:agent SOUL.md /home/agent/.hermes/SOUL.md
