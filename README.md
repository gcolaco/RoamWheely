# Roam Challenge
### Wheely Cool App
This challenge asked to make an app with two screens, one that allows a user to add values to “The Wheel”, and one where the Wheel can be spun for a random result.


## Build:
- Xcode version  12.5
- iPhone
- ![Swift ](https://img.shields.io/badge/Swift-5-orange.svg?style=flat)


## More
* [Personal challenges](#personal-challenges)
* [Pictures](#pictures)
* [Video](#video)

## Personal Challenges
While developing this app I encountered the following challenges:
* How would I persist the user data?
	-
	For this app I decided to use **Userdefaults** instead of coredata, realm or any other kind of data store. The reason why I decided to use that was because of its simplicity to implement. Since we were only storing a simple data type, it was very convenient to use Userdefaults. 
* Which architecture should I use?
	 -
	 I decided to use **MVC**. Don't get me wrong, I do love MVVM, but for this app we were only saving an user option for the wheel, which was of type *string*. So I could simply just make an array of String for the wheel options, but I decided to made a Model, that have an option to add of type String. For data persistence I made a PersistenceManager that handles the *save*, *retrieve* and *delete* data. So having view model was kind of "pointless", since the manager does a great job and it is very reusable.

* How to make the wheel
	-
	This was definitely the bigger challenge of the app. The reason for that is that I didn't wan't to use third party libraries. I made a huge search on that and found amazing(and up to date) ones in Swift Manager Package and Cocoapods. So I had the feeling  that making the wheel by myself was reinvent the wheels. But I had to get out of my comfort zone, and make this the way I could. For that, in my searches I found the Ray Wenderlich post that makes one, but in Objective-c. So I based mine on that, but not only that, I had to re-learn about Bezier Path, angles and some transformations. That definitely took way longer that I wish it would. So for that particular reason, I think that using **third party libraries would be the better option.** 
	
## Pictures
**App works in dark and light mode**

<img src="https://user-images.githubusercontent.com/6657364/126241771-c476f6d5-e36c-47ed-87a8-c25b43a34335.png" width="200" height="400">

<img src="https://user-images.githubusercontent.com/6657364/126241778-6bb64781-528b-4b20-abfc-d272cd929455.png" width="200" height="400">
<img src="https://user-images.githubusercontent.com/6657364/126241782-bd0930f5-2aba-4710-bc72-3407ec1cfa1a.png" width="200" height="400">
<img src="https://user-images.githubusercontent.com/6657364/126241786-18e933c3-a693-4c99-90b6-238e64c67131.png" width="200" height="400">
<img src="https://user-images.githubusercontent.com/6657364/126241788-5c85bea0-5dcf-4261-a29e-5daf4efa5cc2.png" width="200" height="400">
<img src="https://user-images.githubusercontent.com/6657364/126241791-e49537b4-ea82-424b-8011-25eb7a448a9b.png" width="200" height="400">


## Video

https://user-images.githubusercontent.com/6657364/126244410-2757b88a-6d97-4fef-8dc1-4e87ed7c3c34.mp4

*The lag on the video it is due to the simulator*
