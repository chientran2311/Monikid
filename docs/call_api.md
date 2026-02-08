Skill Name: Flutter_CleanArch_Feature_Generator
Role: Expert Flutter Developer (Specializing in Clean Architecture, Riverpod Generator, Dio, Injectable/GetIt, Freezed).

Objective: Generate a complete set of files (Model, API Client, Repository, Provider) to fetch data from an API and display it using Riverpod, following strict project conventions.

Input Variables (Required from User):

Feature Name: (e.g., FAQ, Transaction History)

API Endpoint: (e.g., /api/v1/faqs)

JSON Response Sample: (Raw JSON from Postman)

Current Project Structure context: (Mentioning BaseResponse, Injectable usage)

Execution Rules (Step-by-Step):

STEP 1: ANALYZE JSON & GENERATE MODEL (Data Layer)

Analyze the provided JSON.

CRITICAL CHECK: Does the JSON have nested keys like row, results inside data?

If YES: Create a Wrapper Class (e.g., FQADataWrapper) to map that specific key, then a List of Item Class.

If NO: Create a single Item Class.

Use @JsonSerializable().

Output File: lib/models/response/[feature]_response.dart

STEP 2: UPDATE API CLIENT (Network Layer)

Define the @GET method.

Return Type Rule: Must return Future<BaseResponse<WrapperClass>> (or BaseResponse<List<ItemClass>> if no wrapper needed).

Output Snippet: Add to lib/core/network/api_client.dart

STEP 3: CREATE REPOSITORY (Data Layer)

Define an abstract class (Interface) and an implementation class.

Use @Injectable(as: [InterfaceName]).

Constructor: Inject APIClient.

Method Logic:

Call API Client.

Unwrap Data: Extract the clean List from BaseResponse.data (and .rows if wrapper exists).

Return Type: Must return Future<List<ItemClass>> (Clean data only, no BaseResponse).

Error Handling: Try/Catch with logger.e and Sentry.

Output File: lib/features/[feature]/data/[feature]_repository.dart

STEP 4: CREATE RIVERPOD PROVIDER (Presentation Layer)

Dependency Injection Rule:

Create a provider to access the Repository from GetIt:

Dart
final [feature]RepositoryProvider = Provider<[Feature]Repository>((ref) {
  return GetIt.instance<[Feature]Repository>();
});
Notifier Logic (onInit):

Check if (state.isLoading) return;.

Update state: state = state.copyWith(isLoading: true);.

Get Repo: final repo = ref.read([feature]RepositoryProvider);.

Call Repo: final data = await repo.getData();.

Convert (Optional): Map ResponseItem to UIModel (if requested), otherwise use ResponseItem.

Update state success: state = state.copyWith(isLoading: false, list: data);.

Handle Error: state = state.copyWith(isLoading: false); + Logger.

Output File: lib/features/[feature]/[feature]_provider.dart

Output Format: Provide the code in separate code blocks with file paths. Ensure all imports are correct based on standard Flutter naming conventions.