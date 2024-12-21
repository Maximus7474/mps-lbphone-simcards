# Contributing Guide

Thank you for contributing to our project! To maintain a clean, consistent, and collaborative development process, please adhere to the following guidelines:

## Commit Messages
- Use the [Conventional Commits](https://gist.github.com/qoomon/5dfcdf8eec66a051ecd85625518cfd13) format for commit messages. This ensures a clear history and makes it easier to generate changelogs.
  - Example:
    ```
    feat: add new authentication system
    fix: resolve login button alignment issue
    docs: update contributing guide
    ```
- Prefix your commits with one of the following types:
  - `feat`: A new feature
  - `fix`: A bug fix
  - `docs`: Documentation changes
  - `style`: Code style changes (formatting, missing semi-colons, etc.)
  - `refactor`: Code restructuring without changing functionality
  - `test`: Adding or modifying tests
  - `chore`: Maintenance tasks (e.g., build system or dependency updates)

## New Features
- Before implementing a new feature, please [open a feature request](#).
- Describe the problem the feature aims to solve and provide a high-level implementation overview. This allows us to discuss its relevance and design before development begins.

## Bug Reports and Issues
- Use the provided issue template when reporting bugs.
- Include sufficient information, such as:
  - Steps to reproduce
  - Expected behavior
  - Actual behavior
  - Environment details (e.g., OS, browser version, Node.js version)
- Reports without sufficient information may be closed.

## Pull Requests
- Follow the pull request template when submitting your PR.
- Reference the issue or feature request your PR addresses.
- Ensure your code passes all tests and linters before submission.
- Avoid large, unrelated changes within a single PR.

## Code Style Guidelines
### Variables
- Use camelCase for local variables:
  ```lua
  local localVariable = 42
  ```
- Use PascalCase for global variables:
  ```lua
  GlobalVariable = "Hello"
  ```
- Files loaded with `require` should always use PascalCase:
  ```lua
  local ConfigLoader = require "ConfigLoader"
  ```
  Refer to [ox_lib documentation](https://overextended.dev/ox_lib/Modules/Require/Shared) on how require works

### Comments
- Leave comments wherever the code might be hard to understand:
  ```lua
  -- This loop processes user permissions for edge cases
  for _, permission in ipairs(permissions) do
      -- process permission
  end
  ```

## General Contribution Guidelines
- **Testing**: Each feature should be fully tested to ensure correctness and reliability.
- **Documentation**: Update relevant documentation if your changes affect the public API or behavior.
- **Consistency**: Follow the existing codebase style and conventions.
- **Collaborate**: Be respectful in discussions and consider feedback from reviewers and maintainers.

By following these guidelines, you help us maintain the quality and usability of this project. Thank you for your contributions!

