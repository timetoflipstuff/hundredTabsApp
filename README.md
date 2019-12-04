# Hundred Cells App
This repository contains Pink Team's implementation of the hundred TableView cells task.

Initially, images load via picsum.photos API. Each image is stored in Core Data on download. Whenever a cell is reloaded while its image has already been downloaded, the contents of that cell are withdrawn from Core Data via NSFetchResultController.
