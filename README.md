# EllaMD: API

<p align="center">
  <a href="https://circleci.com/gh/ellamd/ellamd-api/tree/develop"><img src="https://circleci.com/gh/ellamd/ellamd-api.svg?style=svg&circle-token=a5d8ec3af1db2a04d593b37278915986cf0ccde9" alt="CircleCI"></a>
  <a href="https://www.skylight.io/app/applications/vSzOYlC0bRm9"><img src="https://badges.skylight.io/status/vSzOYlC0bRm9.svg?token=f7LtAkGted3pa4QgNJ34WD1Mj1-6r96FOjGoW5JAOLo" alt="Skylight"></a>
</p>

This repository houses the EllaMD application API. This API powers the front end in the `ellamd-ui` repository.

> **Note:** This README isn't fully fleshed out. Reach out to @kamkha with questions about the repository.

## Configuration
The repository is missing one file necessary to run the app: *config/application.yml*. That YAML file contains all of the configuration — API keys, etc. — required to run the application. We manage our secrets with Figaro. In development, Figaro will load the configuration from *config/application.yml*. For staging and production on Heroku, you should use the command-line `figaro` tool to set the Heroku environment variables, e.g. with `figaro heroku:set --environment staging --remote staging` and `figaro heroku:set --environment production --remote production`. The production environment must also provide the `DATABASE_URL` environment variable. Heroku Postgres will handle this by default.

## Quickstart
This repository houses a Rails-based application that serves a pure JSON API.

Ensure you have Ruby installed e.g. via RVM. This repository contains a [.ruby-gemset](.ruby-gemset) file to instruct RVM to use the "ellamd" gemset and a [.ruby-version](.ruby-version) file to instruct RVM to use Ruby 2.4.0. The Ruby version is also defined at the top of the [Gemfile](Gemfile).

Run `bundle` to install the application's dependencies.

Run `rails server` to run the application.

## Notes
### API formatting
Within the Rails app, attribute names are *underscored*, like `preferred_fragrance`. Our JSON API, however, uses *dashed* attribute names, like `preferred-fragrance`. There is middleware in place in the application to handle the conversion between underscored and dashed attributes transparently, so all code, including rendering code in the serializers, should just use the standard underscored attribute names.

### Devise and our user models
There are four roles that our users can take on:
- [**Customers**](app/models/users/customer.rb) are the end users of the application. They're the ones that submit profiles, upload photos, pay for prescriptions, and receive skincare products. They're also the only ones that can register publicly.
- [**Physicians**](app/models/users/physician.rb) log in, view Customers, and add Diagnoses and Prescriptions for them.
- [**Pharmacists**](app/models/users/pharmacist.rb) log in, view Prescriptions, download them, then submit tracking information. The application doesn't track the external fulfillment process right now, so we assume that the Pharmacists are fulfilling the Prescription when the PDF is downloaded, and we rely on the Pharmacists to submit tracking information for the fulfilled Prescription.
- [**Administrators**](app/models/users/administrator.rb) can do all of the above.

All four of the above *used to* inherit from a **User** model, but due to a shift in specifications, the application moved towards a slightly less conventional way of implementing the user/role system. There is a model, [**Identity**](app/models/users/identity.rb), which serves as the central Devise model (i.e. what most people would name User). It has a polymorphic `belongs_to` association which ties it to a "User": a Customer, Physician, Pharmacist, or Administrator. The [HasIdentity](app/models/users/concerns/has_identity.rb) concern manages the inverse association for those User models.

### Linting, testing, etc.
The codebase is linted via Rubocop, though there are currently no pre- or post-commit hooks to enforce that linting. There is also, unfortunately, little explicit testing in the repository right now. As the product stabilizes though, testing can — and should — be introduced.
