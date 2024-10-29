struct EventsResponse: Decodable {
    let events: [Event]

    enum OuterKeys: String, CodingKey {
        case embedded = "_embedded"
    }

    enum EmbeddedKeys: String, CodingKey {
        case events
    }

    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: OuterKeys.self)
        let embeddedContainer = try outerContainer.nestedContainer(keyedBy: EmbeddedKeys.self, forKey: .embedded)
        self.events = try embeddedContainer.decode([Event].self, forKey: .events)
    }
}
