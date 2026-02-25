# CLAUDE.md

## Project Overview

dm-core is the core library of DataMapper, a Ruby ORM. Provides property definitions, query building, associations, identity mapping, dirty tracking, lazy loading, and adapter-based data store abstraction. Version 1.3.0.beta. CustomInk fork maintained by Fenix team, Tier 4.

## Tech Stack

- **Language**: Ruby
- **Type**: Ruby gem (`dm-core`)
- **Key deps**: addressable (~> 2.2.6), virtus (~> 0.5)
- **Dev deps**: rake (~> 0.9.2), rspec (~> 1.3.2) -- NOTE: RSpec 1.x, not modern RSpec 3.x
- **Adapter ecosystem**: Pluggable via dm-do-adapter + database-specific gems. Ships with InMemoryAdapter.

## Development Setup

```bash
bundle install
ADAPTER=sqlite bundle install   # Optional: specify adapter for integration testing
```

## Testing

```bash
bundle exec rake spec           # Run all specs
```

Uses RSpec 1.3.x. Specs organized by API visibility: `spec/public/`, `spec/semipublic/`, `spec/unit/`. Shared specs in `lib/dm-core/spec/shared/` exported for adapter/plugin gems.

## Architecture & Key Conventions

- **Resource pattern**: Models include `DataMapper::Resource`, declare properties inline
- **Repository/Adapter pattern**: `DataMapper.setup(:name, uri)` registers adapters
- **Identity Map**: Same DB row always returns same Ruby object within repository block
- **Persistence state machine**: Transient -> Clean -> Dirty -> Clean in `resource/persistence_state/`
- **Finalization**: `DataMapper.finalize` must be called after all models loaded
- **API visibility tiers**: `public`, `semipublic`, `private` (reflected in specs and YARD tags)

## Review Focus Areas

- **API visibility**: Check `@api` YARD tags -- public changes are breaking
- **Shared spec compatibility**: Changes affect downstream adapter/plugin gems
- **Backwards compatibility**: `backwards.rb` maintains shims
- **RSpec 1.x syntax**: Uses `Spec::Runner`, not `RSpec.describe`
- **Documentation**: Yardstick enforces 100% coverage threshold
