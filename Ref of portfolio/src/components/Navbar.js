import React, { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { FaSun, FaMoon, FaBars, FaTimes } from 'react-icons/fa';

const NAV_ITEMS = [
  { label: 'About',          href: '#about'          },
  { label: 'Skills',         href: '#skills'         },
  { label: 'Projects',       href: '#projects'       },
  { label: 'Experience',     href: '#experience'     },
  { label: 'Certifications', href: '#certifications' },
  { label: 'Blog',           href: '#blog'           },
  { label: 'Contact',        href: '#contact'        },
];

const Navbar = ({ theme, toggleTheme, activeSection }) => {
  const [isOpen,   setIsOpen]   = useState(false);
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    const fn = () => setScrolled(window.scrollY > 30);
    window.addEventListener('scroll', fn, { passive: true });
    return () => window.removeEventListener('scroll', fn);
  }, []);

  useEffect(() => {
    document.body.style.overflow = isOpen ? 'hidden' : '';
    return () => { document.body.style.overflow = ''; };
  }, [isOpen]);

  const close = () => setIsOpen(false);

  return (
    <motion.nav
      className={`navbar${scrolled ? ' navbar--scrolled' : ''}`}
      initial={{ y: -70, opacity: 0 }}
      animate={{ y: 0,   opacity: 1 }}
      transition={{ duration: 0.55, ease: 'easeOut' }}
    >
      <a href="#home" className="logo" onClick={close}>
        Farmanullah<span className="logo-dot">.</span>
      </a>

      {/* Desktop */}
      <ul className="nav-links desktop-nav">
        {NAV_ITEMS.map(({ label, href }) => {
          const id       = href.replace('#', '');
          const isActive = activeSection === id;
          return (
            <li key={label}>
              <a href={href} className={isActive ? 'nav-active' : ''}>
                {label}
                {isActive && (
                  <motion.span
                    className="nav-active-dot"
                    layoutId="nav-dot"
                    transition={{ type: 'spring', stiffness: 400, damping: 30 }}
                  />
                )}
              </a>
            </li>
          );
        })}
        <li>
          <button className="theme-toggle" onClick={toggleTheme} aria-label="Toggle theme">
            <AnimatePresence mode="wait">
              <motion.span
                key={theme}
                initial={{ rotate: -90, opacity: 0, scale: 0.5 }}
                animate={{ rotate: 0,   opacity: 1, scale: 1   }}
                exit={{    rotate:  90, opacity: 0, scale: 0.5 }}
                transition={{ duration: 0.25 }}
              >
                {theme === 'dark' ? <FaSun /> : <FaMoon />}
              </motion.span>
            </AnimatePresence>
          </button>
        </li>
      </ul>

      {/* Mobile controls */}
      <div className="mobile-controls">
        <button className="theme-toggle" onClick={toggleTheme} aria-label="Toggle theme">
          {theme === 'dark' ? <FaSun /> : <FaMoon />}
        </button>
        <button className="hamburger" onClick={() => setIsOpen(o => !o)} aria-label="Toggle menu" aria-expanded={isOpen}>
          <AnimatePresence mode="wait">
            <motion.span
              key={isOpen ? 'x' : 'm'}
              initial={{ rotate: -90, opacity: 0 }}
              animate={{ rotate: 0,   opacity: 1 }}
              exit={{    rotate:  90, opacity: 0 }}
              transition={{ duration: 0.2 }}
            >
              {isOpen ? <FaTimes /> : <FaBars />}
            </motion.span>
          </AnimatePresence>
        </button>
      </div>

      {/* Mobile overlay */}
      <AnimatePresence>
        {isOpen && (
          <motion.div
            className="mobile-menu"
            initial={{ opacity: 0, y: '-100%' }}
            animate={{ opacity: 1, y: 0       }}
            exit={{    opacity: 0, y: '-100%'  }}
            transition={{ type: 'tween', duration: 0.32 }}
          >
            <div className="mobile-menu-orb mobile-menu-orb--1" />
            <div className="mobile-menu-orb mobile-menu-orb--2" />
            <ul className="mobile-nav-links">
              {NAV_ITEMS.map(({ label, href }, i) => (
                <motion.li
                  key={label}
                  initial={{ opacity: 0, x: -40 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: i * 0.07 }}
                >
                  <a href={href} onClick={close} className={activeSection === href.replace('#','') ? 'nav-active' : ''}>
                    <span className="mobile-nav-num">0{i+1}.</span>
                    {label}
                  </a>
                </motion.li>
              ))}
            </ul>
          </motion.div>
        )}
      </AnimatePresence>
    </motion.nav>
  );
};
export default Navbar;