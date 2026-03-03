import Quickshell.Io
 
JsonObject {
    property bool enabled: true
    property Model model : Model {}

    // Template for the model
    component Model : JsonObject {
        property string model: ""
        property string apiUrl: ""
        property string apiKey: ""
        
        // This holds the custom GLM properties
        property JsonObject extraBodyProperties: JsonObject {}
        
        // Helper to get the auth header
        readonly property string authHeader: "Bearer " + apiKey
    }
}