# Step Competition App - Backend Architecture and Planned Features

## Backend Architecture:

### Technology Stack:
- Node.js with Express framework and REST api
- MongoDB as the database using Mongoose for object modeling

### Schemas:
- User Schema: Represents user information, including email, password, profile picture, and status emote.
- Friend Schema: Defines the relationship between users, allowing users to add friends by email.
- Competition Schema: Represents a competition instance, including participants, start time, end time, and step counts.
- Group Competition Schema: Represents a group competition instance, including participants, start time, end time, and step counts.

## Planned Backend Communication:

1. **User Management:**
   - User signup: Accepts user credentials and creates a new user in the database.
   - User login: Authenticates user credentials and generates an access token for subsequent API calls.
   - User profile: Retrieves and updates user profile information.

2. **Friend Management:**
   - Add friend: Accepts the friend's email and establishes a friendship connection between users.
   - Delete friend: Removes the friend connection between users.
   - Get friends list: Retrieves the list of friends for a specific user.

3. **Competition Management:**
   - Create competition: Allows a user to propose a competition with selected friends or participants.
   - Accept competition: Enables a user to accept a proposed competition.
   - Update step counts: Retrieves step counts from fitness tracker APIs and updates the competition and user data.
   - Get competition details: Retrieves competition details, including participants and step counts.
   - Get user's competition progress: Retrieves the user's step count and progress in the competition.

## Planned Features:

1. **Signup and Login:**
   - User registration with email and password.
   - Authentication using access tokens for secure API calls.

2. **User Profile:**
   - Profile picture upload or selection.
   - Selection of status emotes to display alongside the profile picture.

3. **Friend Management:**
   - Ability to add friends by registered email.
   - Friend list management, including deletion of friends.

4. **Competition Functionality:**
   - Creation of one-on-one competitions with selected friends.
   - Acceptance of proposed competitions.
   - Retrieval and update of step counts from fitness tracker APIs.
   - Calculation of competition progress and leaderboards.
   - Support for group competitions with multiple participants.

5. **Notifications:**
   - Push notifications for competition updates and challenges.

6. **Achievements and Rewards:**
   - Implementation of badges or achievements based on competition milestones.
   - Rewards or unlocking of special features for achieving specific targets.

7. **Reminders and Goals:**
   - Setting of step goals and reminders to encourage users to reach their targets.

8. **Data Visualization:**
   - Display of leaderboards to show the rankings of participants.
   - Visualization of competition progress and step counts.

## Fitness Tracker API Support:

To provide compatibility with popular fitness trackers, I plan to create classes for each tracker, implementing the logic for authorizing and communicating with the respective APIs. This approach allows for a modular and extensible codebase.

1. Create Exportable Classes: Generate exportable classes, each corresponding to a specific fitness tracker, such as Samsung Galaxy Watches, Fitbit Bands/Watches, Garmin Watches/Bands, Mi Bands, and Apple Watches.

2. Class Logic: Each class will encapsulate the logic required to authorize and interact with the respective fitness tracker API. This includes authentication, fetching step counts, and handling API responses.

3. Standardize Functions: Develop a set of standardized functions in each class to ensure consistency in interfacing with the different fitness tracker APIs. This will help simplify the integration process and facilitate code maintenance.

4. Switch-Case Implementation: In main frontend code, use a switch-case or conditional statements to determine the selected fitness tracker and control the flow of execution. Set a specific value or variable to indicate which logic should be used.

By following this approach, I can support multiple fitness trackers while keeping the codebase clean and manageable. If new fitness trackers become popular in the future, I can simply add a new exportable class with its own logic and update the switch-case statements accordingly.

Popular Fitness Trackers:
- Samsung Galaxy Watches
- Fitbit Bands/Watches
- Garmin Watches/Bands
- Mi Bands
- Apple Watches

Note: Ensure that I review the documentation and terms of use for each fitness tracker API to understand any limitations, rate limits, or restrictions that may impact the implementation.
