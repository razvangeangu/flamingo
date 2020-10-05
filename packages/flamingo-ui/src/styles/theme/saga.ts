import { call, put, takeLatest } from 'redux-saga/effects';
import { request } from 'utils/request';
import { actions } from './slice';

const ipInfoKey = '07bddd08097853';

export function* getSunsetSunrise() {
  try {
    const { loc } = yield call(
      request,
      `https://ipinfo.io?callback&token=${ipInfoKey}`,
    );

    var infoGeo = loc.split(',');
    var geo = {
      latitude: infoGeo[0],
      longitude: infoGeo[1],
    };

    const {
      results: { sunset, sunrise },
    } = yield call(
      request,
      `https://api.sunrise-sunset.org/json?lat=${geo.latitude}&lng=${geo.longitude}&formatted=0`,
    );

    if (sunset && sunrise) {
      yield put(
        actions.sunsetSunriseLoaded({
          sunset,
          sunrise,
        }),
      );
    }
  } catch (err) {
    if (err.response?.status === 404) {
      // yield put(actions.error(APIErrorType.RESPONSE_ERROR));
    }
  }
}

/**
 * Root saga manages watcher lifecycle
 */
export function* sunsetSunriseSaga() {
  yield takeLatest(actions.loadSunsetSunrise.type, getSunsetSunrise);
}
