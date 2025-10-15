# Changelog

All notable changes to HPDebugKit will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Local Server feature for response caching and offline development
- Network monitoring and request logging
- Performance metrics tracking
- Enhanced crash reporting tools

## [1.0.0] - 2024-10-15

### Added
- Initial release of HPDebugKit
- Core debugging utilities and version information
- Comprehensive file management system (`HPFileManager`)
- Type-safe UserDefaults management with enum-based keys (`HPUserDefaultsManager`)
- SwiftUI-based settings interface (`HPSettingsView`)
- Directory access utilities (`HPDirectory`)
- Predefined UserDefaults keys (`HPUserDefaultsKey`)

### Features
- **HPDebugKit**: Main entry point with version and debug information
- **HPFileManager**: File and directory operations including:
  - Directory creation and management
  - File existence checking
  - File writing (text, JSON, data)
  - File operations (copy, move, remove)
  - Directory content listing
  - File size utilities
- **HPUserDefaultsManager**: Type-safe UserDefaults with:
  - Generic save/fetch methods
  - Specialized methods for common types
  - Codable object support
  - Bulk operations
  - Utility methods (clear, remove, check existence)
  - Debug operations (print data)
- **HPSettingsView**: SwiftUI interface for package configuration
- **HPDirectory**: Easy access to iOS directories (documents, cache, temp, app support)
- **HPUserDefaultsKey**: Predefined keys for common use cases

### Technical Details
- iOS 16.0+ support
- Swift 5.9+ compatibility
- SwiftUI integration with proper availability attributes
- Cross-platform compilation support
- Thread-safe implementation
- Comprehensive error handling and logging

### Documentation
- Complete README with installation and usage instructions
- Detailed API documentation
- Quick start guide for developers
- Code examples and best practices

---

## Version History

### v1.0.0 (Current)
- **Release Date**: October 15, 2024
- **Features**: Core debugging utilities, file management, UserDefaults management, settings UI
- **Platform Support**: iOS 16.0+
- **Swift Version**: 5.9+

### Future Versions

#### v1.1.0 (Planned)
- **Target Date**: Q4 2024
- **Features**: 
  - Local Server functionality
  - Response caching system
  - Offline development support
  - Mock server capabilities

#### v1.2.0 (Planned)
- **Target Date**: Q1 2025
- **Features**:
  - Network monitoring
  - Request/response logging
  - Performance metrics
  - Enhanced debugging tools

#### v2.0.0 (Future)
- **Target Date**: Q2 2025
- **Features**:
  - Major UI overhaul
  - Advanced analytics
  - Custom plugin system
  - Enhanced developer experience

---

## Migration Guide

### From v0.x to v1.0.0

This is the initial release, so no migration is needed.

### Future Migration Notes

When upgrading between major versions, please check this section for any breaking changes and migration steps.

---

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details on how to contribute to HPDebugKit.

## License

HPDebugKit is released under the MIT License. See [LICENSE](LICENSE) for details.
