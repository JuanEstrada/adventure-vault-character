# 07. Deployment View

## Deployment Assumption

Adventure Vault Character runs entirely on a user-owned Android device in the
current architecture.

## Deployment Structure

### Android Device

The Android device hosts:

- the Adventure Vault Character Flutter application
- the local Drift database backed by SQLite
- locally available imported XML content files or imported content records

## Operational Characteristics

- The application must remain usable with no network connection.
- All core session-time interactions occur on-device.
- No mandatory backend runtime is assumed.
- Future synchronization capabilities must be introduced without changing the
  fundamental on-device deployment model.
