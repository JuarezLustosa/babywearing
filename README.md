# README

[![Build Status](https://travis-ci.org/rubyforgood/babywearing.svg?branch=master)](https://travis-ci.org/rubyforgood/babywearing)
[![Maintainability](https://api.codeclimate.com/v1/badges/ac4e12c6fda4398c9dd2/maintainability)](https://codeclimate.com/github/rubyforgood/babywearing/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ac4e12c6fda4398c9dd2/test_coverage)](https://codeclimate.com/github/rubyforgood/babywearing/test_coverage)

# Babywearing

The [Mid-Atlantic Babywearing](https://midatlanticbabywearing.org) organization
is dedicated to supporting the wearing of babies and toddlers for all
caregivers. The MAB Volunteers love holding their babies, toddlers and older
children close with baby carriers and work to spread that joy throughout the
south-eastern and south-central areas of Pennsylvania.

## What is Babywearing?

Babywearing is a method of carrying a baby, toddler or older child close against
one’s body using any of a variety of types of carriers. Babywearing is a tool
that has been utilized all over the world for many centuries, allowing
caretakers to engage in daily activities while staying connected with the child
and enjoying additional bonding time.

Check out the
[many benefits](https://midatlanticbabywearing.org/benefits-of-babywearing/) of
babywearing.

## About this Project

This app is multi-tenant, using [acts_as_tenent](https://github.com/ErwinM/acts_as_tenant)

Each tenant is an organization. Each organization will have distinct carriers,etc.
The entities that will be separate are all the ones with `organization_id` fields,
plus any that belong to any records with `organization_id` fields (e.g. loans are
tied to things with `organization_id` even though they do not need such a field themselves).

The app will know which organization the user is in (or is visiting) by looking
at the subdomain.

There is a special organization with subdomain `admin`. This will manage all
non-organization records (at this time just `Categories`). It will have its own
set of users. This organization will have different menus (basically it will
only need access to non-organizational resources). See the `db/seeds.rb` for info
on which organizations and users exist after running seeds.

To access the organization in dev, use `<subdomain>.lvh.me:3000`.
Our current seed organizations are midatlantic and acme.

MAB has a lending library so that their members can try different types of
carriers and find what works best for their family. They currently have software
that works pretty well, but is a strain on their budget. The new software will keep
track of members & dues as well as the lending library items and their due
dates.

This project aims to provide MAB with a new Lending Library that is more cost
effective and provides the same capabilities as their existing system with an
emphasis on tailoring the experience to better suit the needs of this
organization. The primary set of features this project will focus on includes:

- Managing inventory of hundreds of carriers across multiple locations

- Allowing Members to create or update their account information

- Using volunteers to check in and check out carriers from inventory

- Recording (not processing) financial transactions such as late fees and
  membership dues

  - Simplifying the process to waive late fees

- Improved notification of activities to members including:

  - Due date reminders for checked out items

  - Updates or changes to events and item due dates

- Signing agreements and waivers to participate in the organization

Some additional stretch goals include:

- Transferring inventory between locations (and tracking that history)

- Event attendance sign in

  - Fast sign in for existing Members

  - Easy transition to create new accounts for new Members

- Assign location preferences to Members

- Opt-in text message for meeting and check out reminders using Twilio

### Technical considerations

The volunteers in this group are very mobile and are using their personal phones
or tablets (mostly iPad minis) to capture event attendance, register users, and
process transactions. This project needs to consider a mobile-first design to
continue to provide the users the flexibility of working remote without having
to carry a laptop. Some events are also more of an ad-hoc popup so a phone could be the only
device available in those moments.

## Development

### Ruby Version

This app uses Ruby version 2.6.3, Rails version 5.2.3, and PostgreSQL 11.4

### Setup

- Clone the repo
- run `bin/setup`

### Install ImageMagick

ImageMagick is needed for the pages with images of carriers
run `brew install imagemagick`

### Maintainability

We're currently using Code Climate for code assessment. You can see the current settings in `.codeclimate.yml` and can read more about their Maintainability checks [here](https://docs.codeclimate.com/docs/maintainability).

### Run tests

Run `rspec` to run all tests
or
Run `rspec path/to/spec.rb` to run a specific file

### Start the app

Run `rails s` and browse to http://midatlantic.lvh.me:3000/ or another subdomain

## How to Contribute

_We ♥ contributors!_

By participating in this project, you agree to abide by the
Ruby for Good [Code of Conduct](code-of-conduct.md).

Look for issues with `help wanted` label.  

Please let us know you plan to work on an issue by commenting on the issue that you would like to work on it.  We will assign the issue to you and take off the `help wanted` label.  

Please note if you submit a PR for an issue that someone else has already claimed we will not be able to merge your PR, even if you submit first.  

Before you start working on an issue, please check that someone hasn't already claimed an issue.  We try to take the label off as soon as possible, but sometimes there's a delay.  This project and all Ruby For Good projects are all volunteer run, so we're sometimes not able to get to this immediately.   

We welcome all types of contributions, but any pull requests that address open
issues, have test coverage, or are tagged with the next milestone will be
prioritized. Please read our [How to Contribute](CONTRIBUTING.md) guide for more
information.
