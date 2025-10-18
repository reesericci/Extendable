import ExtensionFoundation
import Foundation

@MainActor @preconcurrency
public struct ConnectableConfiguration: AppExtensionConfiguration {

	private var handler: @MainActor (NSXPCConnection) -> Bool

	@MainActor @preconcurrency
	public init(onConnection connectionHandler: @escaping @Sendable (NSXPCConnection) -> Bool) {
		self.handler = connectionHandler
	}

	nonisolated public func accept(connection: NSXPCConnection) -> Bool {
		MainActor.assumeIsolated {
			handler(connection)
		}
	}
}
