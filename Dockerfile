# Hermes agent image for Podpiwas coders: kagent's Hermes sandbox plus our persona.
# The base is pinned by digest: Substrate admission accepts digest-pinned images only,
# and this is the image kagent 0.10.5 uses by default.
FROM ghcr.io/kagent-dev/kagent/acp-sandbox-hermes@sha256:6c224c7f07d576055db38e85847a9e9dbc9ca4818ce6f55442393b79ba1441fb

USER root
# git is in the base image, an SSH client is not: the agent pushes over SSH with its deploy key.
RUN apt-get update && apt-get install -y --no-install-recommends openssh-client \
    && rm -rf /var/lib/apt/lists/*
# GitHub's published host keys (api.github.com/meta), so the first push needs no prompt.
COPY github_known_hosts /etc/ssh/github_known_hosts
# GIT_SSH_COMMAND, set by vibe-control in the harness env together with the key.
COPY --chmod=755 vibe-git-ssh /usr/local/bin/vibe-git-ssh
USER agent

# Hermes reads its persona from $HERMES_HOME/SOUL.md; HOME is /home/agent.
COPY --chown=agent:agent SOUL.md /home/agent/.hermes/SOUL.md
