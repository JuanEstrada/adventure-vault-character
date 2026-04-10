# ADR-002: Adopt an Offline-First Architecture

## Status

Accepted

## Context

Adventure Vault Character must remain dependable during tabletop sessions where
network connectivity may be unavailable or undesirable. The product also needs
to support future synchronization without making connectivity mandatory.

## Decision

Design Adventure Vault Character as an offline-first client application in
which local data and local business logic remain authoritative for core user
flows.

## Consequences

The application can support uninterrupted session-time use and a simpler
initial deployment model. Future synchronization must be additive and
reconcile with an existing local source of truth, which introduces later
complexity around identity, conflict resolution, and synchronization metadata.
