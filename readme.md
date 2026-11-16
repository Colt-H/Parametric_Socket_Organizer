# Parametric Socket Organizer

Creates a socket organizer using OpenSCAD meant for 3D printing. I didn't like any of the available options I'd found online and wanted a configurable one that would be able to work with any socket brand, type, or design since I have many different ones in my toolbox. 

### inputs
- socket_diameter - Measured diameter of the socket. 
- socket_clearance - clearance around the outside of the socket to the organizer walls. Can be made smaller to hold the sockets tighter.
- number_of_sockets - The number of sockets in the organizer.
- overall_height - The height of the organizer. I typically make mine about 10mm high to keep them a little more secure.
- spacing_offset - This parameter allows you to space the sockets out more, needed for sockets like ball swivel style where the base is smaller than the socket head.
- drive_size - size of square socket drive. 0.250 for 1/4, 0.375 for 3/8, 0.500 for 1/2. You can cheat this up a little bit (a few thousandths) if you like the sockets to stick more. 

## Upcoming
- combine drive sizes

## Changelog

- 0.1.0 - Created a 1/4 drive model
- 0.2.0 - Rounded the corners of the organizer
- 0.3.0 - Added parameter for drive size
- 0.4.0 - Added socket clearance parameter
- 0.4.1 - Updated socket nub chamfered top as the original calculation didn't work with the updated drive size
- 0.5.0 - Added error checking for user inputs
- 0.5.1 - Incorrect socket hole error checking fixed

## Credits
[RoundedCube By Daniel Upshaw](https://danielupshaw.com/openscad-rounded-corners/)