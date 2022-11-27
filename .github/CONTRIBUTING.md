# How to contribute to this module

> Please note: As a loose rule any pull requests for general code cleanup will generally be merged when a new version is released. I have a limited number of hours per week to review and test pull requests. I will do my best to test pull requests within a reasonable time frame, but no guarantees can be made.

## **Did you find a bug?**

* **Ensure the bug was not already reported** by searching on GitHub under [Issues](https://github.com/Celerium/SentinelOne-PowerShellWrapper/issues).

* If you're unable to find an open issue addressing the problem, [open a new one](https://github.com/Celerium/SentinelOne-PowerShellWrapper/issues/new/choose).
  * Be sure to include a **title and clear description**, as much relevant information as possible, and a **code sample** or an **executable test case** demonstrating the expected behavior that is not occurring.

## **Did you write a patch that fixes a bug?**

* [ ] Submit a pulling request to the **development** branch
* [ ] Ensure the pull request description clearly describes the problem and solution.
* [ ] If updating documentation make sure to update the tracking CSV in the docs folder if needed
* [ ] Make sure the **ModuleVersion** number is updated in the **SentinelOneAPI.psd1** file
  * MAJOR version when you make incompatible API changes
  * MINOR version when you add functionality in a backwards-compatible manner
  * PATCH version when you make backwards-compatible bug fixes

If the feature is accepted and I have time to test, the pull request will be approved.

## **Do you intend to add a new feature or change an existing one?**

* Suggest your change by creating a GitHub issue tagged with "Enhancement"

* Create a branch and start working on your new feature, following feedback from the community.

* Once the new feature is ready,

  * [ ] Make sure the ModuleManifest "ModuleVersion" number is updated
  * [ ] Update any documentation if needed
  * [ ] Update the tracking CSV in the docs folder if needed
  * [ ] Submit a pulling request to the **development** branch

If the feature is accepted and I have time to test, the pull request will be approved.

Thanks! :heart:

---

> Based off of the Ruby on Rails project [contribution guide](https://github.com/rails/rails/blob/master/CONTRIBUTING.md).
