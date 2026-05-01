// ty XertroV "https://github.com/XertroV/tm-editor-plus-plus"
uint16 GetOffset(const string &in className, const string &in memberName) {
    // throw exception when something goes wrong.
    auto ty = Reflection::GetType(className);
    if (ty is null) throw("Bad type: " + className);
    auto memberTy = ty.GetMember(memberName);
    if (memberTy is null) throw("Bad member: " + memberName);
    if (memberTy.Offset == 0xFFFF) throw("Invalid offset: 0xFFFF");
    return memberTy.Offset;
}

const uint16 O_EDITORCAMERACTRLORBITAL_TARGETED_POS = GetOffset("CGameControlCameraEditorOrbital", "m_TargetedPosition");
// vec2
const uint16 O_EDITORCAMERACTRLORBITAL_occ_MinXZ = O_EDITORCAMERACTRLORBITAL_TARGETED_POS + 0x18;
// vec2
const uint16 O_EDITORCAMERACTRLORBITAL_occ_MaxXZ = O_EDITORCAMERACTRLORBITAL_TARGETED_POS + 0x20;
// vec2
const uint16 O_EDITORCAMERACTRLORBITAL_occ_YBounds = O_EDITORCAMERACTRLORBITAL_TARGETED_POS + 0x28;

void UnlockOrbitalCameraBounds(CGameControlCameraEditorOrbital@ camera) {
    Dev::SetOffset(camera, O_EDITORCAMERACTRLORBITAL_occ_MinXZ, vec2(-90000000.0));
    Dev::SetOffset(camera, O_EDITORCAMERACTRLORBITAL_occ_MaxXZ, vec2(90000000.0));
    Dev::SetOffset(camera, O_EDITORCAMERACTRLORBITAL_occ_YBounds, vec2(-100.0, 4000.0));
}

void Main() {
    while (true) {
        auto app = GetApp();
        auto editor = cast<CGameCtnEditorFree>(app.Editor);
        if (editor !is null) {
            auto camera = cast<CGameControlCameraEditorOrbital>(editor.OrbitalCameraControl);
            if (camera !is null) {
                UnlockOrbitalCameraBounds(camera);
                camera.m_MinVAngle = -500.0;
                camera.m_MaxVAngle = 500.0;
                camera.m_MinDistance = 0.1;
                camera.m_MaxDistance = 150000.0;
                camera.m_ParamPanSpeed_OnZoomMin = 400.0;
            }
        }
        yield();
    }
}
