# Project README

This project is a project management application developed using Flutter, integrating various features for efficient project and task management.

---

## Part 1: App Development

### Features:

The app should include the following features:

1. **User Authentication:** Allow users to sign up, log in, and log out.
2. **Project Creation:** Enable users to create and manage projects, including tasks, deadlines, and team members.
3. **Task Management:** Allow users to create, assign, and track tasks within projects.
4. **Project Analytics:** Display analytics for each project, such as progress, completion rate, and team productivity.
5. **Email Notifications:** Sends emails automatically to users when they are assigned to a task.

---

## Part 2: Database Decision-Making

### Task:

Write a short report explaining your choice of database for this application. Address the following:

1. **Selection Criteria:** Explain the criteria you used to choose the database.
2. **Comparison:** Compare the chosen database with at least one alternative, discussing the pros and cons.
3. **Implementation Plan:** Describe how you plan to implement the database in your app, including data structure and integration.

### Database Decision Report:

1. **Selection Criteria:**

   - **Criteria Used:** Performance, scalability, ease of integration with Flutter, and cost-effectiveness were the primary criteria.
   - **Chosen Database:** Firebase Firestore was chosen due to its real-time syncing capabilities, seamless integration with Flutter, and robust scalability options.

2. **Comparison:**

   - **Firebase Firestore:**
     - **Pros:** Real-time updates, offline support, seamless integration with Firebase services, scalable, and good documentation.
     - **Cons:** Costs can escalate with usage, complex querying may require denormalization.
   - **Alternative Considered (Supabase):**
     - **Pros:** Open-source, PostgreSQL-based, offers real-time updates, and provides strong authentication options.
     - **Cons:** Relatively newer, may have fewer integrations compared to Firebase.

3. **Implementation Plan:**
   - **Data Structure:** Use collections for projects and tasks, documents for project details, and subcollections for tasks under each project.
   - **Integration:** Integrate Firebase Firestore with Flutter using the `cloud_firestore` package, ensuring data flows smoothly between frontend and backend.

---

## Part 3: Custom Code

**Custom Action:**

- **Automated Email Notifications:** Use a relevant pub.dev package (e.g., mailer) to send email notifications when tasks are updated.

---
