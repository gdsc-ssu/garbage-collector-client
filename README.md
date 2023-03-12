## 2023 Google Solution Challenge

# 🌿**Garbage Collection**

![image](https://user-images.githubusercontent.com/85864699/224559377-fffedc06-055c-45b8-b286-798e80cfc7ca.png)

### **Member**

- Sangwon Choi (Department of AI Convergence, Soongsil University)
- Sanghyeon Sim (Department of Computer Science, Soongsil University)
- Jungmin Lee (Department of Computer Science, Soongsil University)
- Hwangon Jang (Department of Software, Soongsil University)

### Introduction Our Solution

- By using our app, users can identify the type of trash they need to dispose of through AI, as well as locate nearby garbage cans
- This will enable them to properly dispose of their waste, contributing to the United Nations' Sustainable Development Goals of Sustainable Cities and Communities, Clean Water and Sanitation, and ultimately creating a cleaner environment for everyone.

### Architecture

- Our app was developed with a flutter on the front end, and we used firebase for authentication/authorization, and google map to locate the trash can. The backend developed a server with a spring boot and distributed it through CloudRun, and the AI model was made into tensorflow and distributed through the compute engine.

![image](https://user-images.githubusercontent.com/85864699/224559342-6ba5c332-b3d3-4e62-a56e-076328ffe65b.png)

### UI

1. **When enter the app, the locations of nearby garbage cans are displayed on the map with green markers.**

![image](https://user-images.githubusercontent.com/85864699/224559320-81c67ed9-051c-47cb-b54d-1bbec6918f39.png)

2. **When  press the camera button to see what trash I'm trying to throw away, then AI tells me the type of trash and recommends a nearby garbage can.**

![image](https://user-images.githubusercontent.com/85864699/224559338-64b18485-2574-456c-8e14-6a53e92d268d.png)
![image](https://user-images.githubusercontent.com/85864699/224559665-1163bafb-7446-48fe-bc61-a9a9d627e6a4.png)

3. **When you click on the recommended garbage can, its location will be marked on the map with a red marker.**

![image](https://user-images.githubusercontent.com/85864699/224559611-940f723b-13f9-4f5e-9ad7-889a1347b329.png)

4. **When the user arrives at the recommended garbage can and disposes of the plastic trash, they will receive a plastic item card as a reward.**

5. **If the garbage can is full, users can report its status to the local government through the "Report" button.**


![image](https://user-images.githubusercontent.com/85864699/224559615-084bbe49-cce3-41bd-8829-dfa673039465.png)

6. **Users can create their own collection of item cards by earning them, and compete with other app users to climb the rankings.**

![image](https://user-images.githubusercontent.com/85864699/224559622-445bc1d6-14d4-45fb-a8d6-c2826d3a3a24.png)
![image](https://user-images.githubusercontent.com/85864699/224559627-c686e92f-9bf5-4cbb-84b2-83273e2f1021.png)
