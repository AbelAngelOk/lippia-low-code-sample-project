@Clockify @Workspace
Feature: Workspace

  Background:
    Given base url https://api.clockify.me/api
    And header x-api-key = M2Y0YzBlMTYtNjQ1YS00MjI1LTgwYWYtYmM2ZmRkMjU0ZWFl
    And header content-type = application/json

  @GetAllMyWorkspaces
  Scenario: Get all my workspaces
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define workspaceId = $.[0].id

  @AddWorkspace
  Scenario: Add Workspace
    Given endpoint /v1/workspaces
    And body jsons/bodies/AddWorkspace.json
    When execute method POST
    Then the status code should be 201
    And response should be $.name = Cool Company
