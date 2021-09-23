import XCTest
@testable import SDL

let SDL_WINDOWPOS_UNDEFINED = Int32(0x1FFF0000)

final class SDLTests: XCTestCase {
    func testSpinLock() throws {
        var lock = SDL_SpinLock()
        SDL_AtomicLock(&lock)
        SDL_AtomicUnlock(&lock)
    }
    
    func testSDLInit() throws {
        let rv = SDL_Init(SDL_INIT_VIDEO)
        XCTAssert(rv >= 0, String(cString: SDL_GetError()))
    }

    func testSDLWindow() throws {
        let rv = SDL_Init(SDL_INIT_VIDEO)
        XCTAssert(rv >= 0, String(cString: SDL_GetError()))

        let window = SDL_CreateWindow("Hello SDL", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 640, 480, SDL_WINDOW_RESIZABLE.rawValue)
        XCTAssertNotNil(window)

        var quit = false
        var event = SDL_Event()
        while !quit {
            if SDL_PollEvent(&event) == 1 {
                if event.type == SDL_QUIT.rawValue {
                    quit = true
                }
            }
        }
        
        SDL_DestroyWindow(window)
    }
    
    func testVulcanLoadLibrary() throws {
        let rv = SDL_Vulkan_LoadLibrary(nil)
        XCTAssertEqual(rv, 0, String(cString: SDL_GetError()))
    }
}
