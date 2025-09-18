import { Config } from '@stencil/core';
import { vueOutputTarget } from '@stencil/vue-output-target';

export const config: Config = {
  namespace: 'demo-stencil-lib',
  outputTargets: [
    {
      type: 'dist',
      esmLoaderPath: '../loader',
    },
    {
      type: 'dist-custom-elements',
    },
    vueOutputTarget({
      componentCorePackage: 'demo-stencil-lib',
      proxiesFile: '../demo-vue-lib/src/components.ts',
      includeDefineCustomElements: true,
    }),
  ],
};
