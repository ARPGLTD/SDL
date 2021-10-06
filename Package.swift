// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

struct TargetConfiguration {
    var name : String
    var cflags : [CSetting] = []
    var lflags : [LinkerSetting] = []
    var sourcePaths : [String] = []
    var excludePaths : [String] = []
}

var sdlConfig = TargetConfiguration(name: "SDL")

#if os(macOS)

sdlConfig.cflags = [
    .define("SDL_VIDEO_OPENGL", to: "0"),
    .define("SDL_VIDEO_OPENGL_ES2", to: "0"), 
    .define("SDL_VIDEO_OPENGL_EGL", to: "0"),
    .define("SDL_VIDEO_OPENGL_CGL", to: "0"),
    .define("SDL_VIDEO_OPENGL_GLX", to: "0"),
    .define("SDL_VIDEO_RENDER_OGL", to: "0"),
    .define("SDL_VIDEO_RENDER_OGL_ES2", to: "0"),
    .unsafeFlags(["-x", "objective-c", "-fno-objc-arc"], .when(platforms: [.macOS])),
    .unsafeFlags(["-x", "objective-c", "-fobjc-weak"], .when(platforms: [.macOS])),
]

sdlConfig.sourcePaths = [
    "src/atomic",
    "src/audio/coreaudio",
    "src/audio/disk",
    "src/audio/dummy",
    // find src/audio -name \*.c -depth 1 | sort -f | xargs -n 1 printf '"%s",\n'
    "src/audio/SDL_audio.c",
    "src/audio/SDL_audiocvt.c",
    "src/audio/SDL_audiodev.c",
    "src/audio/SDL_audiotypecvt.c",
    "src/audio/SDL_mixer.c",
    "src/audio/SDL_wave.c",
    "src/cpuinfo",
    "src/dynapi/SDL_dynapi.c",
    "src/events",
    "src/file",
    "src/filesystem/cocoa",
    "src/haptic/darwin",
    "src/haptic/dummy",
    "src/haptic/SDL_haptic.c",
    "src/hidapi/SDL_hidapi.c",
    "src/joystick/darwin",
    "src/joystick/dummy",
    "src/joystick/hidapi",
    "src/joystick/iphoneos",
    "src/joystick/steam",
    "src/joystick/virtual",
    // find src/joystick -name \*.c -depth 1 | sort -f | xargs -n 1 printf '"%s",\n'
    "src/joystick/SDL_gamecontroller.c",
    "src/joystick/SDL_joystick.c",
    "src/loadso/dlopen",
    "src/loadso/dummy",
    "src/locale/macosx",
    "src/locale/SDL_locale.c",
    "src/misc/macosx",
    "src/misc/SDL_url.c",
    "src/power/macosx",
    "src/power/uikit",
    "src/power/SDL_power.c",
    "src/render/metal/SDL_render_metal.m",
    // FIXME, SPM tries to compile this with clang...
    // "src/render/metal/SDL_shaders_metal.metal",
    "src/render/software",
    "src/render/SDL_d3dmath.c",
    "src/render/SDL_render.c",
    "src/render/SDL_yuv_sw.c",
    "src/sensor/coremotion",
    "src/sensor/dummy",
    "src/sensor/SDL_sensor.c",
    "src/stdlib",
    "src/thread/pthread",
    "src/thread/SDL_thread.c",
    "src/timer/unix",
    "src/timer/SDL_timer.c",
    "src/video/cocoa",
    "src/video/dummy",
    "src/video/yuv2rgb/yuv_rgb.c",
    "src/video/SDL_blit.c",
    "src/video/SDL_blit_0.c",
    "src/video/SDL_blit_1.c",
    "src/video/SDL_blit_A.c",
    "src/video/SDL_blit_auto.c",
    "src/video/SDL_blit_copy.c",
    "src/video/SDL_blit_N.c",
    "src/video/SDL_blit_slow.c",
    "src/video/SDL_bmp.c",
    "src/video/SDL_clipboard.c",
    "src/video/SDL_fillrect.c",
    "src/video/SDL_pixels.c",
    "src/video/SDL_rect.c",
    "src/video/SDL_RLEaccel.c",
    "src/video/SDL_shape.c",
    "src/video/SDL_stretch.c",
    "src/video/SDL_surface.c",
    "src/video/SDL_video.c",
    "src/video/SDL_vulkan_utils.c",
    "src/video/SDL_yuv.c",
    "src/SDL_assert.c",
    "src/SDL_dataqueue.c",
    "src/SDL_error.c",
    "src/SDL_hints.c",
    "src/SDL_log.c",
    "src/SDL.c",
]

// sdlConfig.excludePaths = [
//     "src/video/SDL_egl.c",
//     "src/video/cocoa/SDL_cocoaopengles.m",
//     "src/video/cocoa/SDL_cocoaopengl.m",
// ]

#elseif os(Linux)

sdlConfig.cflags = [
    .define("USING_SWIFT_PACKAGE_MANAGER", to: "1"),
    .define("_REENTRANT", to: "1"),
    .define("HAVE_LINUX_VERSION_H", to: "1"),
    .define("SDL_AUDIO_DRIVER_SNDIO", to: "1"),
    // .define("SDL_AUDIO_DRIVER_PULSEAUDIO", to: "1"),
    // .define("SDL_FILESYSTEM_UNIX", to: "1"),
    // .define("SDL_HAPTIC_LINUX", to: "1"),
    // .define("SDL_INPUT_LINUXEV", to: "1"),
    // .define("SDL_JOYSTICK_LINUX", to: "1"),
    // .define("SDL_LOADSO_DLOPEN", to: "1"),
    // .define("SDL_TIMER_UNIX", to: "1"),
    // .define("SDL_VIDEO_DRIVER_X11", to: "1"),
    // .define("SDL_VIDEO_DRIVER_X11_SUPPORTS_GENERIC_EVENTS", to: "1"),
    // .define("SDL_VIDEO_DRIVER_X11_HAS_XKBKEYCODETOKEYSYM", to: "1"),
    // .define("HAVE_USR_INCLUDE_MALLOC_H", to: "1"),
    // .define("HAVE_STRING_H", to: "1"),
    // the following were derived from ./configure generated Makefile.
    .unsafeFlags(["-mmmx", "-m3dnow", "-msse", "-msse2", "-msse3", "-Wall", "-fno-strict-aliasing"]),
    .unsafeFlags(["-fvisibility=hidden", "-Wdeclaration-after-statement", "-Werror=declaration-after-statement"]),
    .unsafeFlags(["-I/home/linuxbrew/.linuxbrew/include/dbus-1.0"]),
    .unsafeFlags(["-I/home/linuxbrew/.linuxbrew/lib/dbus-1.0/include"]),
]

sdlConfig.lflags = [
    .linkedLibrary("pulse"),
    .linkedLibrary("X11"),
    .linkedLibrary("Xext"),
]

sdlConfig.sourcePaths = [
    "src/atomic",
    "src/audio/alsa",
    "src/audio/disk",
    "src/audio/dsp",
    "src/audio/dummy",
    "src/audio/pulseaudio",
    "src/audio/sndio",
    // find src/audio -name \*.c -depth 1 | sort -f | xargs -n 1 printf '"%s",\n'
    "src/audio/SDL_audio.c",
    "src/audio/SDL_audiocvt.c",
    "src/audio/SDL_audiodev.c",
    "src/audio/SDL_audiotypecvt.c",
    "src/audio/SDL_mixer.c",
    "src/audio/SDL_wave.c",
    "src/core/linux",
    "src/core/unix",
    "src/cpuinfo",
    "src/dynapi/SDL_dynapi.c",
    "src/events",
    "src/file/SDL_rwops.c",
    "src/filesystem/unix",
    "src/haptic/linux",
    "src/haptic/SDL_haptic.c",
    "src/hidapi/SDL_hidapi.c",
    "src/joystick/dummy",
    "src/joystick/hidapi",
    "src/joystick/linux",
    "src/joystick/steam",
    "src/joystick/virtual",
    // find src/joystick -name \*.c -depth 1 | sort -f | xargs -n 1 printf '"%s",\n'
    "src/joystick/SDL_gamecontroller.c",
    "src/joystick/SDL_joystick.c",
    "src/libm",
    "src/loadso/dlopen",
    // "src/loadso/dummy",
    "src/locale/unix",
    "src/locale/SDL_locale.c",
    "src/misc/unix",
    "src/misc/SDL_url.c",
    "src/power/linux",
    "src/power/SDL_power.c",
    "src/render/opengl",
    "src/render/opengles2",
    "src/render/software",
    "src/render/SDL_d3dmath.c",
    "src/render/SDL_render.c",
    "src/render/SDL_yuv_sw.c",
    "src/sensor/dummy",
    "src/sensor/SDL_sensor.c",
    "src/stdlib",
    "src/thread/pthread",
    "src/thread/SDL_thread.c",
    "src/timer/unix/SDL_systimer.c",
    "src/timer/SDL_timer.c",
    "src/video/dummy",
    "src/video/wayland",
    "src/video/x11",
    "src/video/yuv2rgb/yuv_rgb.c",
    "src/video/SDL_blit.c",
    "src/video/SDL_blit_0.c",
    "src/video/SDL_blit_1.c",
    "src/video/SDL_blit_A.c",
    "src/video/SDL_blit_auto.c",
    "src/video/SDL_blit_copy.c",
    "src/video/SDL_blit_N.c",
    "src/video/SDL_blit_slow.c",
    "src/video/SDL_bmp.c",
    "src/video/SDL_clipboard.c",
    "src/video/SDL_egl.c",
    "src/video/SDL_fillrect.c",
    "src/video/SDL_pixels.c",
    "src/video/SDL_rect.c",
    "src/video/SDL_RLEaccel.c",
    "src/video/SDL_shape.c",
    "src/video/SDL_stretch.c",
    "src/video/SDL_surface.c",
    "src/video/SDL_video.c",
    "src/video/SDL_vulkan_utils.c",
    "src/video/SDL_yuv.c",
    "src/SDL_assert.c",
    "src/SDL_dataqueue.c",
    "src/SDL_error.c",
    "src/SDL_hints.c",
    "src/SDL_log.c",
    "src/SDL.c",
]

#elseif os(Windows)

// TODO:  ensure these are compatible with SDL_config_windows.h
sdlConfig.cflags = [
    .define("SDL_VIDEO_OPENGL", to: "0"),
    .define("SDL_VIDEO_OPENGL_ES2", to: "0"),
    .define("SDL_VIDEO_OPENGL_EGL", to: "0"),
    .define("SDL_VIDEO_OPENGL_CGL", to: "0"),
    .define("SDL_VIDEO_OPENGL_GLX", to: "0"),
    .define("SDL_VIDEO_RENDER_OGL", to: "0"),
    .define("SDL_VIDEO_RENDER_OGL_ES2", to: "0"),
    .define("SDL_VIDEO_DRIVER_WINRT", to: "0"),
    .define("SDL_VIDEO_RENDER_D3D11", to: "0"),
    .define("DLL_EXPORT", to: "1"),
    .unsafeFlags(["-msse3"]),
]

sdlConfig.lflags = [
    .linkedLibrary("swiftCore"),
    .linkedLibrary("KERNEL32"),
    .linkedLibrary("USER32"),
    .linkedLibrary("WINMM"),
    .linkedLibrary("OLE32"),
    .linkedLibrary("SETUPAPI"),
    .linkedLibrary("AdvAPI32"),
    .linkedLibrary("IMM32"),
    .linkedLibrary("ONECORE"),
    .linkedLibrary("GDI32"),
]

sdlConfig.sourcePaths = [
    "src/atomic",
    "src/audio/disk",
    "src/audio/directsound",
    "src/audio/dummy",
    "src/audio/wasapi",
    "src/audio/winmm",
    // find src/audio -name \*.c -depth 1 | sort -f | xargs -n 1 printf '"%s",\n'
    "src/audio/SDL_audio.c",
    "src/audio/SDL_audiocvt.c",
    "src/audio/SDL_audiodev.c",
    "src/audio/SDL_audiotypecvt.c",
    "src/audio/SDL_mixer.c",
    "src/audio/SDL_wave.c",
    "src/core/windows",
    "src/cpuinfo",
    "src/dynapi/SDL_dynapi.c",
    "src/events",
    "src/file/SDL_rwops.c",
    "src/filesystem/windows",
    "src/haptic/dummy",
    "src/haptic/windows",
    "src/haptic/SDL_haptic.c",
    "src/hidapi/SDL_hidapi.c",
    "src/joystick/dummy",
    "src/joystick/hidapi",
    "src/joystick/steam",
    "src/joystick/virtual",
    "src/joystick/windows",
    // find src/joystick -name \*.c -depth 1 | sort -f | xargs -n 1 printf '"%s",\n'
    "src/joystick/SDL_gamecontroller.c",
    "src/joystick/SDL_joystick.c",
    "src/libm",
    "src/loadso/dummy",
    "src/loadso/windows",
    "src/locale/windows",
    "src/locale/SDL_locale.c",
    "src/misc/windows",
    "src/misc/SDL_url.c",
    "src/power/windows",
    "src/power/SDL_power.c",
    "src/render/direct3d",
    "src/render/direct3d11",
    "src/render/opengl",
    "src/render/opengles",
    "src/render/opengles2",
    "src/render/software",
    "src/render/SDL_d3dmath.c",
    "src/render/SDL_render.c",
    "src/render/SDL_yuv_sw.c",
    "src/sensor/dummy",
    "src/sensor/windows",
    "src/sensor/SDL_sensor.c",
    "src/stdlib",
    "src/timer/windows",
    "src/timer/SDL_timer.c",
    "src/thread/generic/SDL_syscond.c",
    "src/thread/windows",
    "src/thread/SDL_thread.c",
    "src/video/dummy",
    "src/video/khronos",
    "src/video/windows",
    "src/video/winrt",
    "src/video/yuv2rgb/yuv_rgb.c",
    "src/video/SDL_blit.c",
    "src/video/SDL_blit_0.c",
    "src/video/SDL_blit_1.c",
    "src/video/SDL_blit_A.c",
    "src/video/SDL_blit_auto.c",
    "src/video/SDL_blit_copy.c",
    "src/video/SDL_blit_N.c",
    "src/video/SDL_blit_slow.c",
    "src/video/SDL_bmp.c",
    "src/video/SDL_clipboard.c",
    "src/video/SDL_fillrect.c",
    "src/video/SDL_pixels.c",
    "src/video/SDL_rect.c",
    "src/video/SDL_RLEaccel.c",
    "src/video/SDL_shape.c",
    "src/video/SDL_stretch.c",
    "src/video/SDL_surface.c",
    "src/video/SDL_video.c",
    "src/video/SDL_vulkan_utils.c",
    "src/video/SDL_yuv.c",
    "src/SDL_assert.c",
    "src/SDL_dataqueue.c",
    "src/SDL_error.c",
    "src/SDL_hints.c",
    "src/SDL_log.c",
    "src/SDL.c",
]

#endif

// generate list of exclusions by subtraction.

/// returns the file URL that contains this file, Package.swift.
var packageURL : URL = {
    let processInfo = ProcessInfo.processInfo
    if let manifestPath = processInfo.environment["SWIFT_PACKAGE_ROOT"] {
        return URL(fileURLWithPath: manifestPath)
    }
    return URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
}()

let fileManager = FileManager.default

func find(_ name : String, base: URL? = nil) -> [String] {
    var results : [String] = []
    func recurse(_ dir : String) {
        let root = URL(fileURLWithPath: dir, relativeTo: base).resolvingSymlinksInPath()
        let contents = (try? fileManager.contentsOfDirectory(atPath: root.path)) ?? []
        for path in contents {
            var isDir : ObjCBool = false
            let realPath = URL(fileURLWithPath: path, relativeTo: root).resolvingSymlinksInPath().path
            if fileManager.fileExists(atPath: realPath, isDirectory: &isDir) {
                let entry = dir + "/" + path
                if isDir.boolValue {
                    recurse(entry)
                } else {
                    results.append(entry)
                }
            }
        }
    }
    recurse(name)
    return results
}

func excludePaths(config : TargetConfiguration) -> [String] {
    // 1. don't exclude any explicitly included source paths.
    // 2. don't exclude any source paths that are in explicitly included directories.
    // currently this code is very sensitive to the current working directory.
    // print("packageURL = \(packageURL)")
    let targetURL = URL(fileURLWithPath: "Sources/\(config.name)", relativeTo: packageURL)
    // print("targetURL = \(targetURL.path)")
    func isDirectory(_ path : String) -> Bool {
        var dir : ObjCBool = false
        let url = URL(fileURLWithPath: path, relativeTo: targetURL).resolvingSymlinksInPath()
        return fileManager.fileExists(atPath: url.path, isDirectory: &dir) && dir.boolValue
    }
    let sourcePaths = config.sourcePaths
    let sourceDirectories = sourcePaths.filter(isDirectory).map { $0 + "/" }
    func inIncludedDirectory(_ path : String) -> Bool {
        for dir in sourceDirectories {
            if path.hasPrefix(dir) { return true }
        }
        return false
    }
    let sources = Set(sourcePaths)
    var excludes : [String] = []
    let targetContents = (try? fileManager.contentsOfDirectory(atPath: targetURL.path)) ?? []
    for name in targetContents.filter(isDirectory) {
        excludes += find(name, base: targetURL).filter { path in
            !path.isEmpty && !sources.contains(path) && !inIncludedDirectory(path)
        }
    }
    return excludes
}

// 	Quiet the warnings.
sdlConfig.cflags += [
    .unsafeFlags(["-Wno-everything"]),
]

sdlConfig.excludePaths = [
    "src/hidapi/testgui",
//    "Include/SDL_revision.h.cmake",
//    "Include/SDL_config.h.in",
//    "Include/SDL_config.h.cmake",
]

sdlConfig.excludePaths += excludePaths(config: sdlConfig)
//print("sourcePaths:")
//print(sdlConfig.sourcePaths.joined(separator: "\n"))
//print("excludePaths:")
//print(sdlConfig.excludePaths.joined(separator: "\n"))

let package = Package(
    name: "SDL",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "SDL", type: .dynamic, targets: ["SDL"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SDL",
            exclude: sdlConfig.excludePaths,
            sources: sdlConfig.sourcePaths,
            publicHeadersPath: "Include",
            cSettings: sdlConfig.cflags, linkerSettings: sdlConfig.lflags
        ),
        .testTarget(
            name: "SDLTests",
            dependencies: ["SDL"]
        )
    ]
)
