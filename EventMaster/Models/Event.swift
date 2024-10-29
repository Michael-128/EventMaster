struct Event: Decodable {
    let id: String
    let name: String
    let performer: String
    let date: String //dd.MM.yyyy
    let time: String? //HH:mm
    let dateTime: String // remeber to merge date and time HH:mm dd.MM.yyyy
    let venues: [Venue]
    let genre: String
    let priceRanges: [PriceRange]
    let images: [EventImage]
    let seatMapImage: String?

    enum OuterKeys: String, CodingKey {
        case id, name, dates, images, priceRanges, seatmap, embedded = "_embedded"
    }

    enum SeatmapKeys: String, CodingKey {
        case staticUrl
    }

    enum DatesKeys: String, CodingKey {
        case start
    }

    enum StartKeys: String, CodingKey {
        case localDate, localTime
    }

    enum EmbeddedKeys: String, CodingKey {
        case venues, attractions
    }

    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: OuterKeys.self)
        let datesContainer = try outerContainer.nestedContainer(keyedBy: DatesKeys.self, forKey: .dates)
        let startContainer = try datesContainer.nestedContainer(keyedBy: StartKeys.self, forKey: .start)
        let embeddedContainer = try outerContainer.nestedContainer(keyedBy: EmbeddedKeys.self, forKey: .embedded)
        if outerContainer.contains(.seatmap) {
            let seatmapContainer = try outerContainer.nestedContainer(keyedBy: SeatmapKeys.self, forKey: .seatmap)
            self.seatMapImage = try seatmapContainer.decodeIfPresent(String.self, forKey: .staticUrl)
        } else {
            self.seatMapImage = nil
        }

        let attraction = try embeddedContainer.decode([Attraction].self, forKey: .attractions).first
        let date = try startContainer.decode(String.self, forKey: .localDate)
        let time = try startContainer.decodeIfPresent(String.self, forKey: .localTime)
        let priceRanges = try outerContainer.decodeIfPresent([PriceRange].self, forKey: .priceRanges)

        self.id = try outerContainer.decode(String.self, forKey: .id)
        self.name = try outerContainer.decode(String.self, forKey: .name)
        self.venues = try embeddedContainer.decode([Venue].self, forKey: .venues)
        self.images = try outerContainer.decode([EventImage].self, forKey: .images)
        self.priceRanges = priceRanges ?? []
        self.performer = attraction?.name ?? "Nieznany"
        self.genre = attraction?.classifications.first?.genre.name ?? "Nieznany"
        self.date = try CustomDateFormatter.shared.formatFromISO(date: date)
        self.time = time
        if let time = time {
            self.dateTime = try CustomDateFormatter.shared.formatFromISO(date: date, time: time)
        } else {
            self.dateTime = date
        }
    }
}
