# XBadManners

## CVE Description 

CVE-2018-16323 is a memory leakage in processing XBM images. After XBM image was converted to another image type you can extract leaked memory bytes from image data. 

Discovered by d4d.

## Tool

A pretty simple tool for generating CVE-2018-16323 PoC. Directory ```samples``` contains some pregenerated PoCs easy for use.
For using this tool you should install imagemagick:

```
apt-get -y install imagemagick
```

And check it:

```
convert -v
```

Any version is suitable.

## Usage:

```
Usage poc generator: ./XBadManners.sh gen WIDTHxHEIGHT NAME.xbm [minimal]
		Example gen: ./XBadManners.sh gen 512x512 poc.xbm"
Usage result recovery: ./XBadManners.sh recover SAVED_PREVIEW.png|jpeg|gif|etc
		Example recovery: ./XBadManners.sh recover avatar.png"
```

 Mode ```minimal``` allows you to generate smallest possible XBM's body for pasting in BurpSuite or whatever you want. Minimal mode was tested and it works just fine. You can set any width and height in this mode. 

 Notice that you can extract a whole lot of memory using single image. The only restriction is a limitation for maximum size of the produced image by backend.

 You can try to recover ```preview.png```. If you get readable words in output then this means that everything works just fine.


### Step by step

1. Run ```./XBadManners.sh gen 512x512 poc.xbm``` 
2. Upload PoC to the server.
3. Download preview and run ```./XBadManners.sh recover result.png```

Nice call if preview changes significantly from one upload to another.

## Restrictions

Recovery mode is created for a quick check and should work fine for any ImageMagick supported image formats but it was tested only for png, jpeg and gif.
You can tune logic of memory extraction from image by modifying the script (it's simple but ugly)


## How does it look like?

![Zebra](https://raw.githubusercontent.com/ttffdd/XBadManners/master/preview.png "Memory leak")

XBM is a black and white format. So, any result will look like kind of a zebra (if you have good imagination). Basicly, more black == more data extracted.

## Affected By CVE-2018-16323

Every ImageMagick's build after [that commit](https://github.com/ImageMagick/ImageMagick/commit/d9a8234d211da30baf9526fbebe9a8438ea7e11c) and before [that commit](https://github.com/ImageMagick/ImageMagick/commit/216d117f05bff87b9dc4db55a1b1fadb38bcb786) is vulnerable.
 
## Reference 

* https://nvd.nist.gov/vuln/detail/CVE-2018-16323
* https://www.cvedetails.com/cve/CVE-2018-16323/





