import { DefaultTheme } from 'styled-components';
import { RootState } from 'types';
import { selectTheme, selectThemeKey } from '../selectors';
import * as slice from '../slice';
import { actions } from '../slice';
import { themes } from '../themes';
import { ThemeKeyType, ThemeState } from '../types';

describe('theme slice', () => {
  let state: ThemeState;

  beforeEach(() => {
    state = slice.initialState;
  });

  it('should return the initial state', () => {
    expect(slice.reducer(undefined, { type: '' })).toEqual(state);
  });

  it('should changeTheme', () => {
    expect(slice.reducer(state, actions.changeTheme('dark'))).toEqual<
      ThemeState
    >({ selected: 'dark', sunset: '', sunrise: '' });
  });

  describe('selectors', () => {
    it('selectTheme', () => {
      let state: RootState = {};
      expect(selectTheme(state)).toEqual<DefaultTheme>(themes.light);
      state = {
        theme: { selected: 'system', sunset: '', sunrise: '' },
      };
      expect(selectTheme(state)).toEqual<DefaultTheme>(themes.light);

      state = {
        theme: { selected: 'dark', sunset: '', sunrise: '' },
      };
      expect(selectTheme(state)).toEqual<DefaultTheme>(themes.dark);
    });

    it('selectThemeKey', () => {
      let state: RootState = {};
      expect(selectThemeKey(state)).toEqual<ThemeKeyType>(
        slice.initialState.selected,
      );

      state = {
        theme: { selected: 'system', sunset: '', sunrise: '' },
      };
      expect(selectThemeKey(state)).toEqual<ThemeKeyType>(
        state.theme!.selected,
      );
    });
  });
});
