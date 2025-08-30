import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/repositorys/family_repoistory.dart';
import 'package:baby_monitor/models/family_models/add_family_model.dart';
import 'package:baby_monitor/models/family_models/family_model.dart';
import 'package:baby_monitor/models/family_models/join_family_model.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class FamilyController extends BaseController {
  late FamilyRepoistory _familyRepoistory;
  late AddFamilyModel model;
  var familyModel = FamilyModel().obs;
  var familyLoading = false.obs;
  var hasFamily = false.obs;
  var addFamilyLoading = false.obs;
  var addFamilyModel = AddFamilyModel();
  var joinFamilyLoading = false.obs;
  InterstitialAd? _interstitialAd;
  BannerAd? bottomBannerAd;
  var isBottomLoaded = false.obs;

  FamilyController() {
    _loadInterstitialAd();
    _createBottomBannerAd();
    _familyRepoistory = Get.find();
    getFamily();
  }

  Future<void> _loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId:
          "ca-app-pub-3940256099942544/1033173712", //TODO GEçiş reklamı ıd
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          ad.show();
        },
        onAdFailedToLoad: (error) {
          if (_interstitialAd != null) {
            _interstitialAd!.dispose();
          }
        },
      ),
    );
  }

  _createBottomBannerAd() {
    bottomBannerAd = BannerAd(
      adUnitId:
          "ca-app-pub-3940256099942544/9214589741", //TODO ADS banner ad ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isBottomLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    bottomBannerAd?.load();
  }

  Future getFamily() async {
    try {
      var family = await _familyRepoistory.getDbFamily();
      if (family != null) {
        familyModel.value = family;
      }

      familyLoading.value = true;
      var fml = prepareServiceModel<FamilyModel>(
        await _familyRepoistory.getFamily(getSession()?.id ?? ""),
      );

      if (fml != null) {
        familyModel.value = fml;
        await _familyRepoistory.addOrUpdateFamily(fml);
      } else {
        await _familyRepoistory.clearFamily();
        familyModel.value = FamilyModel();
      }
      familyLoading.value = false;
    } catch (e) {
      familyLoading.value = false;
      exceptionHandle(e);
    }
  }

  Future addFamily() async {
    addFamilyLoading.value = true;
    prepareServiceModel<String>(
      await _familyRepoistory.addFamily(addFamilyModel),
    );
    Get.back();
    addFamilyLoading.value = false;
    succesMessage("Aile Ekleme İşlemi Bşarılı");

    ///TODO treanslate
    getFamily();
    try {} catch (e) {
      addFamilyLoading.value = false;
      exceptionHandle(e);
    }
  }

  Future leaveFamily(String memberId) async {
    try {
      familyLoading.value = true;

      prepareServiceModel<String>(
        await _familyRepoistory.leaveFamily(memberId),
      );
      familyLoading.value = false;
      Get.back();
      succesMessage("Aileden Ayrılma İşlemi Bşarılı"); //TODO translate
      getFamily();
    } catch (e) {
      addFamilyLoading.value = false;
      exceptionHandle(e);
    }
  }

  Future joinFamily(String familyId) async {
    try {
      joinFamilyLoading.value = true;
      prepareServiceModel<String>(
        await _familyRepoistory.joinFamily(JoinFamilyModel(id: familyId)),
      );
      joinFamilyLoading.value = false;
      getFamily();
      Get.back();
    } catch (e) {
      joinFamilyLoading.value = false;
      exceptionHandle(e);
    }
  }

  bool canLeaveFromMaily(String userID) => userID == getSession()?.id;
  @override
  void dispose() {
    _interstitialAd!.dispose();
    super.dispose();
  }
}
