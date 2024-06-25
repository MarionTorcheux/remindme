CREATE TABLE IF NOT EXISTS theme (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(255),
  primaryColor VARCHAR(255),
  secondaryColor VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS user (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(255),
  email VARCHAR(255),
  themeId INT,
  CONSTRAINT FK_user_theme FOREIGN KEY (themeId) REFERENCES theme(id)
);

CREATE TABLE IF NOT EXISTS list (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(255),
  image VARCHAR(255),
  createdAt DATE,
  userId INT,
  CONSTRAINT FK_list_user FOREIGN KEY (userId) REFERENCES user(id)
);

CREATE TABLE IF NOT EXISTS task (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(255),
  description VARCHAR(255),
  startDate DATE,
  endDate DATE,
  priority VARCHAR(255),
  state VARCHAR(255),
  listId INT,
  CONSTRAINT FK_task_list FOREIGN KEY (listId) REFERENCES list(id)
);

CREATE TABLE IF NOT EXISTS attachedFile (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  filePath VARCHAR(255),
  taskId INT,
  CONSTRAINT FK_attachedFile_task FOREIGN KEY (taskId) REFERENCES task(id)
);

CREATE TABLE IF NOT EXISTS historyLog (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  actionDate DATE,
  taskChangeObject VARCHAR(255),
  taskId INT,
  CONSTRAINT FK_historyLog_task FOREIGN KEY (taskId) REFERENCES task(id)
);

CREATE TABLE IF NOT EXISTS share (
  userShareId INT,
  listId INT,
  CONSTRAINT FK_share_user FOREIGN KEY (userShareId) REFERENCES user(id),
  CONSTRAINT FK_share_list FOREIGN KEY (listId) REFERENCES list(id)
);

CREATE TABLE IF NOT EXISTS notification (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  message VARCHAR(255),
  dateNotification DATE,
  userId INT,
  CONSTRAINT FK_notification_user FOREIGN KEY (userId) REFERENCES user(id)
);


INSERT INTO theme (name, primaryColor, secondaryColor) VALUES
('Dark Theme', '#000000', '#FFFFFF'),
('Light Theme', '#FFFFFF', '#000000');


INSERT INTO user (name, email, themeId) VALUES
('Marion', 'marion@gmail.com', 1),
('User', 'user@gmail.com', 2);


INSERT INTO list (name, image, createdAt, userId) VALUES
('Courses', 'groceries.png', '2024-06-15', 1),
('Idées voyages', 'ocean.png', '2024-06-16', 2);


INSERT INTO task (name, description, startDate, endDate, priority, state, listId) VALUES
('Acheter du lait', 'aumoins deux litres pour faire des gâteaux', '2024-06-15', '2024-06-16', 'urgent', 'en cours', 1),
('Finish Report', 'Complete the annual report', '2024-06-16', '2024-06-18', 'Medium', 'In Progress', 2);


INSERT INTO attachedFile (filePath, taskId) VALUES
('/files/milk_receipt.jpg', 1),
('/files/report_draft.docx', 2);


INSERT INTO historyLog (actionDate, taskChangeObject, taskId) VALUES
('2024-06-15', 'tâche modifiée', 1),
('2024-06-16', 'Tâche créé', 2);


INSERT INTO share (userShareId, listId) VALUES
(1, 2),
(2, 1);


INSERT INTO notification (message, dateNotification, userId) VALUES
('Notification de tâche 1 ', '2024-06-15', 1),
('Notification de tâche 2', '2024-06-16', 2);