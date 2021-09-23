import XCTest
@testable import SDL

final class SDLTests: XCTestCase {
    func testSpinLock() throws {
        var lock = SDL_SpinLock()
        SDL_AtomicLock(&lock)
        SDL_AtomicUnlock(&lock)
    }
}
