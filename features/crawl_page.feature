
Feature: crawl site
  In order to index a website
  As a web crawler
  I want to take in a URL and produce CSV containing URL, title and status code.

  @wip
  Scenario: crawl site
    Given a URL
    When a crawl site
    Then I should have csv file containing URL, title and status code