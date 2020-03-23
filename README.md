Group Project - README 
===

# ChatUCI

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Students are able to create and join chatrooms. Students can communicate in these chatrooms and talk amongst themselves about courses, life, etc.

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/NXpw0Xpefh.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:**
- **Mobile:**
- **Story:**
- **Market:**
- **Habit:**
- **Scope:**

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User stays logged in across restarts. 
- [x] User can sign up.
- [x] User can log in. 
- [x] User can log out. 
- [x] User can join a chat room.
- [x] User can talk in a chat room.

**Optional Nice-to-have Stories**

- [x] Pull data directly from UCI schedule of courses using Alamofire and SwiftSoup
- [x] User can search for a chat room
- [x] User can remove chatroom
- [x] User can filter by department when searching for course
- [x] Load messages from button-up in chatroom
- [x] Display pop-up when user adds courses
- [] User can send media (images).

### 2. Screen Archetypes

* [Sign Sign Screen]
   * [User can sign up and sign in]
   * ...
* [Home Screen]
   * [User can join a room]
   * [User can create a room]
   * [User can talk in a room]

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [No tabs]

**Flow Navigation** (Screen to Screen)

* [Home Screen]
   * [Search for a room]
   * [Talk in a room]


  
## Wireframes
[Link to hand drawn wireframe](https://imgur.com/a/Qbnx8NK)



### [BONUS] Digital Wireframes & Mockups
<img src="http://g.recordit.co/oLgfYQBhqa.gif" width=600>

### [BONUS] Interactive Prototype

## Schema 

### Models
Chatroom
|   Property    |      Type     | Description |
| ------------- | ------------- | ------------|
| roomId  | String | unique id of the chatoom |
| creator | String | original creator of the chatroom |
| createdAt | DateTime | date when the chatroom is created |
| updatedAt | DateTime | date when the most recent message is sent |
| numParticipants | Number | the number of participants in a chatroom |
| numMessages | Number | the number of messages in a chatroom |

### Networking
1. Chatroom Dashboard
  - (Read/GET) View user's active chatrooms
  - (Delete) Delete a chatroom currently participating in
2. Join a Chatroom
  - (Read/GET) Join an active chatroom hosted by ChatUCI
3. Create a Chatroom
  - (Create/POST) Create a new chatroom for others to join
4. Participate in a Chatroom
  - (Create/POST) Create a new message in the chatroom
  - (Update/PUT) Update the chatroom with new messages
