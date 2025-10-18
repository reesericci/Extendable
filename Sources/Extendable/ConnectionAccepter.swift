import Foundation
import os.log

public typealias ExtendableConnectionHandler = (NSXPCConnection) throws -> Void

struct ConnectionAccepter {
	private let logger = Logger(subsystem: "com.chimehq.Extendable", category: "ConnectionAccepter")

	let handler: ExtendableConnectionHandler

	init(_ handler: @escaping ExtendableConnectionHandler) {
		self.handler = handler
	}

	func accept(connection: NSXPCConnection) -> Bool {
		logger.debug("accepting connection")

		do {
			try handler(connection)

			logger.debug("accepted connection")

			connection.activate()

			return true
		} catch {
			logger.debug("accepting connection failed: \(String(describing: error), privacy: .public)")

			return false
		}
	}
}
