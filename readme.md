# Parametric Socket Organizer

Creates a socket organizer using OpenSCAD meant for 3D printing. I didn't like any of the available options I'd found online and wanted a configurable one that would be able to work with any socket brand, type, or design since I have many different ones in my toolbox. 

### inputs
- socket_diameter - Measured diameter of the socket. 
- number_of_sockets - The number of sockets in the organizer.
- overall_height - The height of the organizer. I typically make mine about 10mm high to keep them a little more secure.
- spacing_offset - This parameter allows you to space the sockets out more, needed for sockets like ball swivel style where the base is smaller than the socket head.
- drive_size - size of square socket drive. 0.250 for 1/4, 0.375 for 3/8, 0.500 for 1/2.

## Upcoming
- 3/8 and 1/2 drive models (or paramter to chose)
- variable hole sizes

## Changelog

0.1 - Created a 1/4 drive model
0.2 - Rounded the corners of the organizer