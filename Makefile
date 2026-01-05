TARGET = iphone:clang:latest:13.0
LIBRARY_NAME = CirclePopup
SOURCES = Sources/CirclePopup.m
FRAMEWORKS = UIKit

all:
	clang -fobjc-arc -dynamiclib $(SOURCES) -framework UIKit -o $(LIBRARY_NAME).dylib
